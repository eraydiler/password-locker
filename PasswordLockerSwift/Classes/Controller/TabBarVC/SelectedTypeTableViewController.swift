//
//  SelectedTypeTableViewController.swift
//  PasswordLockerSwift
//
//  Created by Eray on 03/04/15.
//  Copyright (c) 2015 Eray. All rights reserved.
//

import UIKit
import CoreData

protocol SelectedTypeTableViewControllerDelegate {
    func allDataDeletedForCategory(_ category: Category)
}

class SelectedTypeTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    // set by former controller
    var category: Category?
    var managedObjectContext: NSManagedObjectContext?
    
    // delegate to send info to tabBar Controller when there is no more data
    var delegate: SelectedTypeTableViewControllerDelegate?
    
    let TAG = "SelectedType TVC"
    
    func configureView() {
        self.title = self.category?.name
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.rightBarButtonItem = self.editButtonItem
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("\(TAG) MemoryWarning", terminator: "")
    }
    
    // MARK: - Fetched results controller
    
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult> {
        // return if already initialized
        if self._fetchedResultsController != nil {
            return self._fetchedResultsController!
        }
        let managedObjectContext = self.managedObjectContext!
        
        let entity = NSEntityDescription.entity(forEntityName: "SavedObject", in: managedObjectContext)
        let sort = NSSortDescriptor(key: "date", ascending: true)
        let req = NSFetchRequest<NSFetchRequestResult>()
        
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
    var _fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?

    // MARK: - fetched results controller delegate
    
    /* called first
    begins update to `UITableView`
    ensures all updates are animated simultaneously */
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.beginUpdates()
    }
    
    /* called:
    - when a new model is created
    - when an existing model is updated
    - when an existing model is deleted */
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
        didChange anObject: Any,
        at indexPath: IndexPath?,
        for type: NSFetchedResultsChangeType,
        newIndexPath: IndexPath?) {
            switch type {
            case .insert:
                self.tableView.insertRows(at: [newIndexPath!], with: UITableViewRowAnimation.fade)
                print("\(TAG) coredata insert")
            case .update:
                let cell = self.tableView.cellForRow(at: indexPath!)
                self.configureCell(cell!, atIndexPath: indexPath!)
                self.tableView.reloadRows(at: [indexPath!], with: UITableViewRowAnimation.fade)
                print("\(TAG) coredata update")
            case .move:
                print("\(TAG) coredata move")
                self.tableView.deleteRows(at: [indexPath!], with: UITableViewRowAnimation.fade)
                self.tableView.insertRows(at: [newIndexPath!], with: UITableViewRowAnimation.fade)
            case .delete:
                print("\(TAG) coredata delete")
                self.tableView.deleteRows(at: [indexPath!], with: UITableViewRowAnimation.fade)
                
                if self.fetchedResultsController.sections![0].numberOfObjects == 0 {
                    // TODO: Butun veriler silinmisse view controller i da sil
                    self.delegate?.allDataDeletedForCategory(self.category!)
                }
            }
    }
    
    /* called last
    tells `UITableView` updates are complete */
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return self.fetchedResultsController.sections!.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.fetchedResultsController.sections![section].numberOfObjects
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "selectedCell", for: indexPath) 

        // Configure the cell...
        configureCell(cell, atIndexPath: indexPath)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            let context = self.fetchedResultsController.managedObjectContext
            
            let objectToBeDeleted: SavedObject = self.fetchedResultsController.object(at: indexPath) as! SavedObject
            let relationships = objectToBeDeleted.mutableSetValue(forKey: "rows")
            
            context.delete(objectToBeDeleted)
            for row in relationships {
                context.delete(row as! NSManagedObject)
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
    
    func configureCell(_ cell: UITableViewCell,
        atIndexPath indexPath: IndexPath) {
        
            let savedObject = self.fetchedResultsController.object(at: indexPath) as! SavedObject
            //            cell.textLabel?.text = savedObject.name
            let label = cell.contentView.subviews[0] as! UILabel
            label.text = savedObject.name
            let imageView = cell.contentView.subviews[1] as! UIImageView
            imageView.image = UIImage(named: savedObject.type.imageName)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let indexPath = self.tableView.indexPathForSelectedRow
        let savedObject = self.fetchedResultsController.object(at: indexPath!) as! SavedObject
        
        if segue.identifier == "toSelectedValuesTVCSegue" {
            let targetVC = segue.destination as! SelectedValuesTableViewController
            targetVC.managedObjectContext = self.managedObjectContext
            targetVC.category = self.category
            targetVC.savedObjectID = savedObject.objectID
//            targetVC.delegate = self.tabBarController as! TabBarController
        }
    }
    
    // MARK: - Helper Methods
    
    func parseDataForTitle(_ data: Array<Dictionary<String, String>>,
        atIndexPath indexPath: IndexPath) -> String {
            
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
