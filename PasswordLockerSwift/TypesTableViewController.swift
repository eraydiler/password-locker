//
//  TypesTableViewController.swift
//  PasswordLockerSwift
//
//  Created by Eray on 03/02/15.
//  Copyright (c) 2015 Eray. All rights reserved.
//

import UIKit
import CoreData

class TypesTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    let TAG = "TypesTableViewController"
    // set by AppDelegate on application startup
    var managedObjectContext: NSManagedObjectContext?
    
    // set by former controller
    var category: Category?
    
    // configure view
    func configureView() {
        self.tableView.rowHeight = 45
        self.navigationItem.title = "Type"
        self.title = self.category?.name
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print(TAG + "memory warning received")
    }
    
    // MARK: - Fetched results controller
    
    /* `NSFetchedResultsController`
    lazily initialized
    fetches the displayed domain model */
    var fetchedResultsController: NSFetchedResultsController {
        // return if already initialized
        if self._fetchedResultsController != nil {
            return self._fetchedResultsController!
        }
        let managedObjectContext = self.managedObjectContext!
        
        /* `NSFetchRequest` config
        fetch all `Item`s
        order them alphabetically by name
        at least one sort order _is_ required */
        let entity = NSEntityDescription.entityForName("Type", inManagedObjectContext: managedObjectContext)
        let sort = NSSortDescriptor(key: "name", ascending: true)
        let req = NSFetchRequest()
        req.entity = entity
        req.sortDescriptors = [sort]
        req.predicate = NSPredicate(format: "category == %@", category!)        
        
        /* NSFetchedResultsController initialization
        a `nil` `sectionNameKeyPath` generates a single section */
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: req, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        aFetchedResultsController.delegate = self
        self._fetchedResultsController = aFetchedResultsController
        
        // perform initial model fetch
        var e: NSError?
        do {
            try self._fetchedResultsController!.performFetch()
        } catch let error as NSError {
            e = error
            print(TAG + " fetch error: \(e!.localizedDescription)")
            abort();
        }
        
        return self._fetchedResultsController!
    }
    var _fetchedResultsController: NSFetchedResultsController?
    
    
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
    
    // create and configure each `UITableViewCell`
    override func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            var cell: UITableViewCell = UITableViewCell()
            cell = tableView.dequeueReusableCellWithIdentifier("TypeCell", forIndexPath: indexPath) 
            self.configureCell(cell, atIndexPath: indexPath)
            return cell
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let indexPath = self.tableView.indexPathForSelectedRow
        let type = self.fetchedResultsController.objectAtIndexPath(indexPath!) as! Type
        
        if segue.identifier == "toValuesTVCSegue" {
            let targetVC = segue.destinationViewController as! ValuesTableViewController
            targetVC.managedObjectContext = self.managedObjectContext
            targetVC.category = self.category
            targetVC.type = type
            targetVC.delegate = self.tabBarController as! TabBarController
        }
    }
    
    // MARK: - Helper Methods
    
    /* helper method to configure a `UITableViewCell`
    ask `NSFetchedResultsController` for the model */
    func configureCell(cell: UITableViewCell,
        atIndexPath indexPath: NSIndexPath) {
            
            let type = self.fetchedResultsController.objectAtIndexPath(indexPath)
                as! Type
            
            let titleLabel = cell.contentView.subviews[0] as! UILabel
            let imageView = cell.contentView.subviews[1] as! UIImageView
            
            titleLabel.text = type.name
            imageView.image = UIImage(named: type.imageName)
    }
}
