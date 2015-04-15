    //
//  ValuesTableViewController.swift
//  PasswordLockerSwift
//
//  Created by Eray on 12/03/15.
//  Copyright (c) 2015 Eray. All rights reserved.
//

import UIKit
import CoreData

    protocol ValuesTableViewControllerDelegate {
        func newDataSaved()
    }
    
class ValuesTableViewController: UITableViewController, NSFetchedResultsControllerDelegate,  EditValuesTableViewControllerDelegate {
    let TAG = "Values TVC"

    // set by former controller
    var category: Category?
    var type: Type?
    
    // hack for handling back button
    var isBackTouched = true
    
    // delegate to send info to tabBar Controller when user saved data
    var delegate: ValuesTableViewControllerDelegate?
    
    func configureView() {
        self.tableView.rowHeight = 44.0
        self.title = self.type?.name
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
            println("\(TAG) back pressed")
        }
        
        if managedObjectContext!.hasChanges  && isBackTouched {
            rollBack()
            println("\(TAG) Changes rolled back")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        println("\(TAG) Memory Warning received")
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections!.count
    }
    
    // ask the `NSFetchedResultsController` for the section
    override func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int)
        -> Int {
            return self.fetchedResultsController.sections![section].numberOfObjects
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
    
    // create and configure each `UITableViewCell`
    override func tableView(tableView: UITableView,
        cellForRowAtIndexPath indexPath: NSIndexPath)
        -> UITableViewCell {

            var reuseIdentifier: String!
            
            if (indexPath.section == 0) {
                reuseIdentifier = "TitleCell"
            } else if (indexPath.section == 1) {
                reuseIdentifier = "ValueCell"
            } else {
                reuseIdentifier = "NoteCell"
            }
            var cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! UITableViewCell
            configureCell(cell, atIndexPath: indexPath)
            return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 68.0
        }
        return 44.0
    }
    
    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("toEditAccountValuesTVCSegue", sender: indexPath)
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            cell.addSubview(Helper.seperatorTopImageView(cell))
        } else {
            cell.addSubview(Helper.seperatorTopImageView(cell))
            cell.addSubview(Helper.seperatorButtomImageView(cell))
        }
    }
    
    // set by AppDelegate on application startup
    var managedObjectContext: NSManagedObjectContext?
    
    // MARK: - Fetched results controller
    
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
        req.predicate = NSPredicate(format: "ANY types == %@", self.type!)
        
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
        didChangeObject object: AnyObject,
        atIndexPath indexPath: NSIndexPath?,
        forChangeType type: NSFetchedResultsChangeType,
        newIndexPath: NSIndexPath?) {
            switch type {
            case .Insert:
                self.tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
                println("\(TAG) coredata insert")
            case .Update:
                let cell = self.tableView.cellForRowAtIndexPath(indexPath!)
                self.configureCell(cell!, atIndexPath: indexPath!)
                self.tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
                println("\(TAG) coredata update")
            case .Move:
                println("\(TAG) coredata move")
                self.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
                self.tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
            case .Delete:
                println("\(TAG) coredata delete")
                self.tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: UITableViewRowAnimation.Fade)
            default:
                return
            }
    }
    
    /* called last
    tells `UITableView` updates are complete */
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }
    
    /* helper method to configure a `UITableViewCell`
    ask `NSFetchedResultsController` for the model */
    func configureCell(cell: UITableViewCell,
        atIndexPath indexPath: NSIndexPath) {
            
//            let sectionsInfo: AnyObject = self.fetchedResultsController.sections![indexPath.section]
            let row = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Row
            
            switch (indexPath.section) {
            case 0:
                let imageView = cell.contentView.subviews[0] as! UIImageView
                var titleLabel = cell.contentView.subviews[1].subviews[0] as! UILabel
                imageView.image = UIImage(named: row.key)
                titleLabel.text = row.value
                break;
            case 1:
                var keyLabel = cell.contentView.subviews[0] as! UILabel
                var valueLabel = cell.contentView.subviews[1] as! UILabel
                keyLabel.text = row.key
                valueLabel.text = row.value
                break;
            case 2:
                var noteLabel = cell.contentView.subviews[0] as! UILabel
                if row.value != "No Note" { noteLabel.textColor = UIColor.blackColor() }
                noteLabel.text = row.value
                break;
                
            default:
                break;
            }
    }
    
    // MARK: - EditValuesTableViewController Delegate
    
    func rowValueChanged() {
        
        let indexPath = self.tableView.indexPathForSelectedRow()
        
        var reuseIdentifier: String! = nil
        if indexPath?.section == 0 {
            reuseIdentifier = "TitleCell"
        }
        else if indexPath?.section == 1 {
            reuseIdentifier = "ValueCell"
        }
        else {
            reuseIdentifier = "NoteCell"
        }
        
        if let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath!) as? UITableViewCell
        {
            configureCell(cell, atIndexPath: indexPath!)
        }
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "toEditAccountValuesTVCSegue" {
            
            let row = self.fetchedResultsController.objectAtIndexPath(sender as! NSIndexPath) as! Row
            let targetVC = segue.destinationViewController as! EditValuesTableViewController
            
            targetVC.managedObjectContext = self.managedObjectContext
            targetVC.rowId = row.objectID
            targetVC.placeholder = row.value
            targetVC.delegate = self
            
            isBackTouched = false
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func saveBarButtonTouched(sender: UIBarButtonItem) {
        isBackTouched = false
        save()
        self.delegate?.newDataSaved()
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK: - Helper Methods
    
    func rollBack() {
        managedObjectContext?.rollback()
    }
    
    func save() {
        
        // Backup changed rows before rollBack
        var fetchedRows = self.fetchedResultsController.fetchedObjects as! [Row]
        
        // Get name
        var name = String("")
        
        // Get Data
        let rows = rowsDictionaries(fetchedRows, name: &name)
        
        // template deki degisiklikeri geri almak icin
        rollBack()
        
        // Insert new entity for SavedObject
        var savedObject = NSEntityDescription.insertNewObjectForEntityForName("SavedObject", inManagedObjectContext: self.managedObjectContext!) as! SavedObject
        
        savedObject.name = name
        savedObject.data = rows
        savedObject.date = NSDate()
        savedObject.type = self.type!
        savedObject.category = self.category!
        
        if self.type == nil || self.category == nil {
            println("\(TAG) nil kaydedildi.")
        }
        
        // Insert new rows
        for row in rows {
            let dict: Dictionary<String, String> = row
            
            var newRow = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: self.managedObjectContext!) as! Row
            
            if let key = dict["key"] {
                newRow.key = key
            } else { println("key is not in the dictionary") }
            
            if let value = dict["value"] {
                newRow.value = value
            } else { println("value is not in the dictionary") }
            
            if let section = dict["section"] {
                newRow.section = section
            } else { println("section is not in the dictionary") }
            
            newRow.savedObject = savedObject
            
            var manyRelation = savedObject.valueForKeyPath("rows") as! NSMutableSet
            manyRelation.addObject(newRow)
        }

        var e: NSError?

        if !Constants.TEST {
            if !managedObjectContext!.save(&e) {
                println("\(TAG) save error: \(e!.localizedDescription)")
                abort()
            }
        }
        
        if Constants.TEST {
            let req = NSFetchRequest(entityName: "SavedObject")
            let fetchArray  = self.managedObjectContext?.executeFetchRequest(req, error: &e)
            for savedObject in fetchArray as! [SavedObject] {
                let arr: Array = savedObject.data
                for a in arr {
                    println("\(TAG) \(a)")
                }
                println()
            }
        }
    }
    
    func rowsDictionaries(rows: [Row], inout name: String) -> Array<Dictionary<String, String>> {
        var dict = [String:String]()
        var arr = [Dictionary<String, String>]()
        
        for row in rows {
            
            if row.section == "0" { name = row.value; } // set SavedObject name
            
            dict["key"] = row.key
            dict["value"] = row.value
            dict["section"] = row.section
            
            arr.append(dict)
        }
        return arr
    }
}
