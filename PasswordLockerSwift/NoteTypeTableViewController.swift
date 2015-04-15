//
//  NoteTypeTableViewController.swift
//  PasswordLockerSwift
//
//  Created by Eray on 23/03/15.
//  Copyright (c) 2015 Eray. All rights reserved.
//

import UIKit
import CoreData

class NoteTypeTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, EditValuesTableViewControllerDelegate {
    
    // set by AppDelegate on application startup
    var managedObjectContext: NSManagedObjectContext?
    
    // hack for handling back button
    var isBackTouched = true
    
    func configureView() {
        self.title = "Note"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        configureView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        isBackTouched = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        if isBackTouched {
            println("back pressed")
        }
        
        if managedObjectContext!.hasChanges  && isBackTouched {
            managedObjectContext?.rollback()
            println("Changes rolled back")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 68.0
        }
        return 392.0
    }
    
    // create and configure each `UITableViewCell`
    override func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {

            var reuseIdentifier: String!
            
            if (indexPath.section == 0) {
                reuseIdentifier = "TitleCell"
            } else if (indexPath.section == 1) {
                reuseIdentifier = "NoteCell"
            }
            var cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! UITableViewCell
            self.configureCell(cell, atIndexPath: indexPath)
            return cell
    }
    
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
        let entity = NSEntityDescription.entityForName("Row", inManagedObjectContext: managedObjectContext)
        let sort = NSSortDescriptor(key: "section", ascending: true)
        let req = NSFetchRequest()
        req.entity = entity
        req.sortDescriptors = [sort]
        req.fetchBatchSize = 20
        let name = "note"
        req.predicate = NSPredicate(format: "key == %@", name)
        
        /* NSFetchedResultsController initialization
        a `nil` `sectionNameKeyPath` generates a single section */
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: req, managedObjectContext: managedObjectContext, sectionNameKeyPath: "section", cacheName: nil)
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
    
    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("toEditNoteTVCSegue", sender: indexPath)
    }
    
    // MARK: - EditValuesTableViewController Delegate
    
    func rowValueChanged() {
        
        let indexPath = self.tableView.indexPathForSelectedRow()
        
        var reuseIdentifier: String!
        if indexPath?.section == 0 {
            reuseIdentifier = "TitleCell"
        }
        else if indexPath?.section == 1 {
            reuseIdentifier = "NoteCell"
        }
        
        if let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath!) as? UITableViewCell
        {
            configureCell(cell, atIndexPath: indexPath!)
        }
    }
    
    /* helper method to configure a `UITableViewCell`
    ask `NSFetchedResultsController` for the model */
    func configureCell(cell: UITableViewCell,
        atIndexPath indexPath: NSIndexPath) {
            
            let row = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Row
            
            switch (indexPath.section) {
            case 0:
                let imageView = cell.contentView.subviews[0] as! UIImageView
                let titleLabel = cell.contentView.subviews[1].subviews[0] as! UILabel
                imageView.image = UIImage(named: row.key)
                titleLabel.text = row.value
                break;
            case 1:
                let valueLabel = cell.contentView.subviews[0] as! UILabel
                valueLabel.text = row.value
                break;
                
            default:
                break;
            }
    }
    
    // MARK: - IBActions
    
    @IBAction func saveBarButtonPressed(sender: UIBarButtonItem) {
        isBackTouched = false
        
        var e: NSError?
        if !managedObjectContext!.save(&e) {
            println("save error: \(e!.localizedDescription)")
            abort()
        }
        self.navigationController?.popViewControllerAnimated(true)
    }    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "toEditNoteTVCSegue" {
            
            let row = self.fetchedResultsController.objectAtIndexPath(sender as! NSIndexPath) as! Row
            let targetVC = segue.destinationViewController as! EditNoteTableViewController

            targetVC.managedObjectContext = self.managedObjectContext
            targetVC.rowId = row.objectID
            targetVC.delegate = self
            
            isBackTouched = false
        }
    }
}
