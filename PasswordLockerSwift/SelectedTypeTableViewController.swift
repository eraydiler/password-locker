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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.title = self.category?.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        print("MemoryWarning")
    }
    
    // MARK: - Fetched results controller
    
    var fetchedResultsController: NSFetchedResultsController {
        // return if already initialized
        if self._fetchedResultsController != nil {
            return self._fetchedResultsController!
        }
        let managedObjectContext = self.managedObjectContext!
        
        let entity = NSEntityDescription.entityForName("SavedData", inManagedObjectContext: managedObjectContext)
        let sort = NSSortDescriptor(key: "date", ascending: true)
        let req = NSFetchRequest()
        req.entity = entity
        req.sortDescriptors = [sort]
        
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: req, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        aFetchedResultsController.delegate = self
        self._fetchedResultsController = aFetchedResultsController
        
        // perform initial model fetch
        var e: NSError?
        if !self._fetchedResultsController!.performFetch(&e) {
            println("fetch error: \(e!.localizedDescription)")
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

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("selectedCell", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        configureCell(cell, atIndexPath: indexPath)
        
        return cell
    }
    
    func configureCell(cell: UITableViewCell,
        atIndexPath indexPath: NSIndexPath) {
        
            let data = self.fetchedResultsController.objectAtIndexPath(indexPath) as SavedData
    }
    
    // MARK: - Helper Methods
    
    func dateString(date:NSDate) -> String {
        let dateFormatter = NSDateFormatter()
        
        var theDateFormat = NSDateFormatterStyle.ShortStyle
        let theTimeFormat = NSDateFormatterStyle.ShortStyle
        
        dateFormatter.dateStyle = theDateFormat
        dateFormatter.timeStyle = theTimeFormat
        
        return dateFormatter.stringFromDate(date)
    }
}
