//
//  SelectedTypeTableViewController.swift
//  PasswordLockerSwift
//
//  Created by Eray on 03/04/15.
//  Copyright (c) 2015 Eray. All rights reserved.
//

import UIKit
import CoreData

class SelectedTypeTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    // set by former controller
    var category: Category?
    var managedObjectContext: NSManagedObjectContext?
    
    let TAG = "SelectedType TVC"
    
    func configureView() {
        self.title = self.category?.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.rightBarButtonItem = self.editButtonItem()
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("\(TAG) MemoryWarning", appendNewline: false)
    }
    
    // MARK: - Fetched results controller
    
    var fetchedResultsController: NSFetchedResultsController {
        // return if already initialized
        if self._fetchedResultsController != nil {
            return self._fetchedResultsController!
        }
        let managedObjectContext = self.managedObjectContext!
        
        let entity = NSEntityDescription.entityForName("SavedObject", inManagedObjectContext: managedObjectContext)
        let sort = NSSortDescriptor(key: "date", ascending: true)
        let req = NSFetchRequest()
        
        req.entity = entity
        req.sortDescriptors = [sort]
        req.predicate = NSPredicate(format: "category == %@", self.category!)
        
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: req, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        aFetchedResultsController.delegate = self
        self._fetchedResultsController = aFetchedResultsController
        
        // perform initial model fetch
        var e: NSError?
        do {
            try self._fetchedResultsController!.performFetch()
        } catch let error as NSError {
            e = error
            print("\(TAG) fetch error: \(e!.localizedDescription)")
            abort();
        }
        
        return self._fetchedResultsController!
    }
    var _fetchedResultsController: NSFetchedResultsController?

    // MARK: - fetched results controller delegate
    
    /* called first
    begins update to `UITableView`
    ensures all updates are animated simultaneously */
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }
    
    /* called:
    - when a new model is created
    - when an existing model is updated
    - when an existing model is deleted */
    func controller(controller: NSFetchedResultsController,
        didChangeObject object: NSManagedObject,
        atIndexPath indexPath: NSIndexPath?,
        forChangeType type: NSFetchedResultsChangeType,
        newIndexPath: NSIndexPath?) {
            switch type {
            case .Insert:
                self.tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
                print("\(TAG) coredata insert")
            case .Update:
                let cell = self.tableView.cellForRowAtIndexPath(indexPath!)
                self.configureCell(cell!, atIndexPath: indexPath!)
                self.tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
                print("\(TAG) coredata update")
            case .Move:
                print("\(TAG) coredata move")
                self.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
                self.tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
            case .Delete:
                print("\(TAG) coredata delete")
                self.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
//            default:
//                return
            }
    }
    
    /* called last
    tells `UITableView` updates are complete */
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return self.fetchedResultsController.sections!.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.fetchedResultsController.sections![section].numberOfObjects
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("selectedCell", forIndexPath: indexPath) 

        // Configure the cell...
        configureCell(cell, atIndexPath: indexPath)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            let context = self.fetchedResultsController.managedObjectContext
            
            let objectToBeDeleted: SavedObject = self.fetchedResultsController.objectAtIndexPath(indexPath) as! SavedObject
            let relationships = objectToBeDeleted.mutableSetValueForKey("rows")
            
            context.deleteObject(objectToBeDeleted)
            for row in relationships {
                context.deleteObject(row as! NSManagedObject)
            }
            
            var e: NSError?
            if let moc = self.managedObjectContext {
                do {
                    try moc.save()
                } catch let error as NSError {
                    e = error
                    print("\(TAG) save error: \(e!.localizedDescription)")
                    abort()
                }
            } else {
                print("\(TAG) managedobjectcontext not found")
                abort()
            }
            
        }
    }
    
    func configureCell(cell: UITableViewCell,
        atIndexPath indexPath: NSIndexPath) {
        
            let savedObject = self.fetchedResultsController.objectAtIndexPath(indexPath) as! SavedObject
            //            cell.textLabel?.text = savedObject.name
            let label = cell.contentView.subviews[0] as! UILabel
            label.text = savedObject.name
            let imageView = cell.contentView.subviews[1] as! UIImageView
            imageView.image = UIImage(named: savedObject.type.imageName)
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let indexPath = self.tableView.indexPathForSelectedRow
        let savedObject = self.fetchedResultsController.objectAtIndexPath(indexPath!) as! SavedObject
        
        if segue.identifier == "toSelectedValuesTVCSegue" {
            let targetVC = segue.destinationViewController as! SelectedValuesTableViewController
            targetVC.managedObjectContext = self.managedObjectContext
            targetVC.category = self.category
            targetVC.savedObjectID = savedObject.objectID
//            targetVC.delegate = self.tabBarController as! TabBarController
        }
    }
    
    // MARK: - Helper Methods
    
    func parseDataForTitle(data: Array<Dictionary<String, String>>,
        atIndexPath indexPath: NSIndexPath) -> String {
            
            var title: String = String()
            let dict: Dictionary<String, String> = data[indexPath.row]
            
            if indexPath.section == 0 {
                title = dict["value"]!
            }
            
            for (key, value) in dict {
                print("\(TAG) key: \(key), value: \(value)")
            }
            
            return title
    }
}
