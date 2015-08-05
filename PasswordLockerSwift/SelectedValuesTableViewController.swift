//
//  SelectedValuesTableViewController.swift
//  PasswordLockerSwift
//
//  Created by Eray on 08/04/15.
//  Copyright (c) 2015 Eray. All rights reserved.
//

import UIKit
import CoreData

class SelectedValuesTableViewController: UITableViewController, NSFetchedResultsControllerDelegate,
    EditValuesTableViewControllerDelegate {
    let TAG = "SelectedValuesTableViewController"
    
    // set by former controller
    var category: Category?
    var savedObjectID: NSManagedObjectID?
    var savedObject: SavedObject?

    var rows: [Row]?
    
    // set by AppDelegate on application startup
    var managedObjectContext: NSManagedObjectContext?    
    
    // hack for handling back button
    var isBackTouched = true
    
    // delegate to send info to tabBar Controller when user saved data
    var delegate: ValuesTableViewControllerDelegate?

    func configureView() {
        
        self.savedObject = self.managedObjectContext?.objectWithID(self.savedObjectID!) as? SavedObject
        if let rows = self.savedObject?.rows.allObjects as? [Row] {
            
            // Set rows property
            self.rows = rows
            
            // Sort by section
            self.rows?.sortInPlace({$0.section < $1.section})
        } else {
            print("\(TAG) no row found")
            abort()
        }
        self.tableView.rowHeight = 44.0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        isBackTouched = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        if isBackTouched {
            print("\(TAG) back pressed")
        }
        
        if managedObjectContext!.hasChanges  && isBackTouched {
            rollBack()
            print("\(TAG) Changes rolled back")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("\(TAG) memory warning", appendNewline: false)
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
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }
    
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
            }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections!.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchedResultsController.sections![section].numberOfObjects
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var reuseIdentifier: String!
        let sectionsInfo: AnyObject = self.fetchedResultsController.sections![indexPath.section]

        if (sectionsInfo.indexTitle == "0") {
            reuseIdentifier = "TitleCell"
        } else if (sectionsInfo.indexTitle == "1") {
            reuseIdentifier = "ValueCell"
        } else {
            reuseIdentifier = "NoteCell"
        }
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) 
        configureCell(cell, atIndexPath: indexPath)

        return cell
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
//        let sectionsInfo: AnyObject = self.fetchedResultsController.sections![section]
//        
//        switch (sectionsInfo.indexTitle) {
//        case "0":
//            return "Title Header"
//            
//        case "1":
//            return "Values Header"
//            
//        case "2":
//            return "Notes Header"
//            
//        default:
//            return nil
//        }
        
        if let sections = self.fetchedResultsController.sections {
            let currentSection = sections[section] as NSFetchedResultsSectionInfo
            
            switch (currentSection.indexTitle!) {
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
        
        return nil
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 68.0
        }
        return (self.category?.name != "Note") ? (44.0) : (250.0)
    }
    
    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("toEditSelectedValuesTVCSegue", sender: indexPath)
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            cell.addSubview(Helper.seperatorTopImageView(cell))
        } else {
            cell.addSubview(Helper.seperatorTopImageView(cell))
            cell.addSubview(Helper.seperatorButtomImageView(cell))
        }
    }
    
    // MARK: - EditValuesTableViewController Delegate
    
    func rowValueChanged() {
        
        let indexPath = self.tableView.indexPathForSelectedRow
        let sectionsInfo: AnyObject = self.fetchedResultsController.sections![indexPath!.section]
        
        var reuseIdentifier: String! = nil
        if sectionsInfo.indexTitle == "0" {
            reuseIdentifier = "TitleCell"
        }
        else if sectionsInfo.indexTitle == "1" {
            reuseIdentifier = "ValueCell"
        }
        else {
            reuseIdentifier = "NoteCell"
        }
        
        if let cell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath!)
        {
            configureCell(cell, atIndexPath: indexPath!)
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func saveBarButtonTouched(sender: UIBarButtonItem) {
        isBackTouched = false
        save()
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func backBarButtonTouched(sender: UIBarButtonItem) {
        print("\(TAG) back clicked")
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
//        let indexPath = self.tableView.indexPathForSelectedRow      
        
        if segue.identifier == "toEditSelectedValuesTVCSegue" {
            
            let row = self.fetchedResultsController.objectAtIndexPath(sender as! NSIndexPath) as! Row

            let targetVC = segue.destinationViewController as! EditSelectedValuesTableViewController
            targetVC.managedObjectContext = self.managedObjectContext
            targetVC.rowID = row.objectID
            targetVC.placeholder = row.value
            targetVC.delegate = self
            
            isBackTouched = false
        }
    }
    
    // MARK: - Helper Methods
    
    func configureCell(cell: UITableViewCell,
        atIndexPath indexPath: NSIndexPath) {
            
            let row = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Row
            if let sectionsInfo: AnyObject = self.fetchedResultsController.sections![indexPath.section] {
                
                switch (sectionsInfo.indexTitle!!) {
                case "0":
                    
                    if let imageView = cell.contentView.subviews[0] as? UIImageView {
                        imageView.image = UIImage(named: row.key)
                    } else {
                        print(TAG + " " + "imageView not found")
                    }
                    
                    if let titleLabel = cell.contentView.subviews[1].subviews[0] as? UILabel {
                        titleLabel.text = row.value
                    } else {
                        print(TAG + " " + "titleLabel not found")
                    }
                    
                    //                let imageView = cell.contentView.subviews[0] as! UIImageView
                    //                var titleLabel = cell.contentView.subviews[1].subviews[0] as! UILabel
                    //                imageView.image = UIImage(named: row.key)
                    //                titleLabel.text = row.value
                    break;
                case "1":
                    
                    if let keyLabel = cell.contentView.subviews[0] as? UILabel {
                        keyLabel.text = row.key
                    } else {
                        print(TAG + " " + "keyLabel not found")
                    }
                    
                    if let valueLabel = cell.contentView.subviews[1] as? UILabel {
                        valueLabel.text = row.value
                    } else {
                        print(TAG + " " + "valueLabel not found")
                    }
                    
                    //                var keyLabel = cell.contentView.subviews[0] as! UILabel
                    //                var valueLabel = cell.contentView.subviews[1] as! UILabel
                    //                keyLabel.text = row.key
                    //                valueLabel.text = row.value
                    
                    break;
                case "2":
                    
                    if let noteLabel = cell.contentView.subviews[0] as? UILabel {
                        if row.value != "No Note" { noteLabel.textColor = UIColor.blackColor() }
                        noteLabel.text = row.value
                    } else {
                        print(TAG + " " + "noteLabel not found")
                    }
                    
                    //                var noteLabel = cell.contentView.subviews[0] as! UILabel
                    //                noteLabel.text = row.value
                    break;
                    
                default:
                    break;
                }
            }
    }
    
    func rollBack() {
        managedObjectContext?.rollback()
    }
    
    func save() {
        
        // Set savedObject name
        let rows = self.fetchedResultsController.fetchedObjects as! [Row]
        
        for row in rows {
            if row.section == "0" {self.savedObject?.name = row.value}
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
        
//        if !managedObjectContext!.save(&e) {
//            println("\(TAG) save error: \(e!.localizedDescription)")
//            abort()
//        }
    }
}
