//
//  CategoriesTableViewController.swift
//  PasswordLockerSwift
//
//  Created by Eray on 03/02/15.
//  Copyright (c) 2015 Eray. All rights reserved.
//

import UIKit
import CoreData

class CategoriesTableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    // set by AppDelegate on application startup
    var managedObjectContext: NSManagedObjectContext?

    func configureView() {
        self.tableView.rowHeight = 50.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
       // println(managedObjectContext)
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        let entity = NSEntityDescription.entityForName("Category", inManagedObjectContext: managedObjectContext)
        let sort = NSSortDescriptor(key: "name", ascending: true)
        let req = NSFetchRequest()
        req.entity = entity
        req.sortDescriptors = [sort]
        
        /* NSFetchedResultsController initialization
        a `nil` `sectionNameKeyPath` generates a single section */
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
    
    // create and configure each `UITableViewCell`
    override func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {
            var cell: UITableViewCell = UITableViewCell()
            cell = tableView.dequeueReusableCellWithIdentifier("CategoryCell", forIndexPath: indexPath) as UITableViewCell
            self.configureCell(cell, atIndexPath: indexPath)
            return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.

        let indexPath = self.tableView.indexPathForSelectedRow()
        let category = self.fetchedResultsController.objectAtIndexPath(indexPath!) as Category
        
        if segue.identifier == "toAccountTypeTVCSegue" {
            let targetVC = segue.destinationViewController as TypesTableViewController
            targetVC.managedObjectContext = self.managedObjectContext
            targetVC.category = category
        }
    }
    
    /* helper method to configure a `UITableViewCell`
    ask `NSFetchedResultsController` for the model */
    func configureCell(cell: UITableViewCell,
        atIndexPath indexPath: NSIndexPath) {
            
            let category = self.fetchedResultsController.objectAtIndexPath(indexPath)
                as Category
            
            let imageView = cell.contentView.subviews[0] as UIImageView
            var titleLabel = cell.contentView.subviews[1] as UILabel
            
            imageView.image = UIImage(named: category.imageName)
            titleLabel.text = category.name
    }
}
