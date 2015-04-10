//
//  SelectedValuesTableViewController.swift
//  PasswordLockerSwift
//
//  Created by Eray on 08/04/15.
//  Copyright (c) 2015 Eray. All rights reserved.
//

import UIKit
import CoreData

class SelectedValuesTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    let TAG = "SelectedValuesTableViewController"
    
    // set by former controller
    var category: Category?
    var savedObjectID: NSManagedObjectID?
    var savedObject: SavedObject?

    var rows: [Row]?
    
    // set by AppDelegate on application startup
    var managedObjectContext: NSManagedObjectContext?

    func configureView() {
        
        self.savedObject = self.managedObjectContext?.objectWithID(self.savedObjectID!) as? SavedObject
        if let rows = self.savedObject?.rows.allObjects as? [Row] {
            
            // Set rows property
            self.rows = rows
            
            // Sort by section
            self.rows?.sort({$0.section < $1.section})
        } else {
            println("\(TAG) no row found")
            abort()
        }
        self.tableView.rowHeight = 44.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("\(TAG) memory warning")
    }
    
    // MARK: - FetchedResultsController
    
    var fetchedResultsController: NSFetchedResultsController {
        // return if already initialized
        if self._fetchedResultsController != nil {
            return self._fetchedResultsController!
        }
        let managedObjectContext = self.managedObjectContext!
        
        /* `NSFetchRequest` config */
        let entity = NSEntityDescription.entityForName("Row", inManagedObjectContext: managedObjectContext)
        let sort = NSSortDescriptor(key: "section", ascending: true)
        let req = NSFetchRequest()
        req.entity = entity
        req.sortDescriptors = [sort]
        req.fetchBatchSize = 20
        req.predicate = NSPredicate(format: "savedObject == %@", self.savedObject!)
        
        /* NSFetchedResultsController initialization a `nil` `sectionNameKeyPath` generates a single section */
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: req, managedObjectContext: managedObjectContext, sectionNameKeyPath: "section", cacheName: nil)
        aFetchedResultsController.delegate = self
        self._fetchedResultsController = aFetchedResultsController
        
        // perform initial model fetch
        var e: NSError?
        if !self._fetchedResultsController!.performFetch(&e) {
            println("\(TAG) fetch error: \(e!.localizedDescription)")
            abort();
        }
        
        return self._fetchedResultsController!
    }
    var _fetchedResultsController: NSFetchedResultsController?

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections!.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchedResultsController.sections![section].numberOfObjects
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var reuseIdentifier: String!
        
        if (indexPath.section == 0) {
            reuseIdentifier = "TitleCell"
        } else if (indexPath.section == 1) {
            reuseIdentifier = "ValueCell"
        } else {
            reuseIdentifier = "NoteCell"
        }
        var cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as UITableViewCell
        configureCell(cell, atIndexPath: indexPath)

        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        let sectionsInfo: AnyObject = self.fetchedResultsController.sections![section]
        
        switch (sectionsInfo.indexTitle) {
        case "0":
            return "Title Header"
            
        case "1":
            return "Values Header"
            
        case "2":
            return "Notes Header"
            
        default:
            return nil
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 68.0
        }
        return 44.0
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let indexPath = self.tableView.indexPathForSelectedRow()
        
        if let row = self.rows?[indexPath!.row]{
            
        }
        
//        if segue.identifier == "toSelectedValuesTVCSegue" {
//            
//            let targetVC = segue.destinationViewController as SelectedValuesTableViewController
//            targetVC.managedObjectContext = self.managedObjectContext
//            targetVC.category = self.category
//            targetVC.type = savedObject.type
//            targetVC.savedObjectID = row.objectID
//            targetVC.delegate = self.tabBarController as TabBarController
//        }
    }
    
    // MARK: - Helper Methods
    /* helper method to configure a `UITableViewCell`
    ask `NSFetchedResultsController` for the model */
    func configureCell(cell: UITableViewCell,
        atIndexPath indexPath: NSIndexPath) {
            
            let row = self.fetchedResultsController.objectAtIndexPath(indexPath) as Row
            
            switch (indexPath.section) {
            case 0:
                let imageView = cell.contentView.subviews[0] as UIImageView
                var titleLabel = cell.contentView.subviews[1].subviews[0] as UILabel
                imageView.image = UIImage(named: row.key)
                titleLabel.text = row.value
                break;
            case 1:
                var keyLabel = cell.contentView.subviews[0] as UILabel
                var valueLabel = cell.contentView.subviews[1] as UILabel
                keyLabel.text = row.key
                valueLabel.text = row.value
                break;
            case 2:
                var noteLabel = cell.contentView.subviews[0] as UILabel
                noteLabel.text = row.value
                break;
                
            default:
                break;
            }
    }
}
