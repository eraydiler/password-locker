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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isBackTouched = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let managedObjectContext = NSManagedObjectContext.mr_default()

        if isBackTouched {
            print("\(TAG) back pressed")
        }
        
        if managedObjectContext.hasChanges  && isBackTouched {
            NSManagedObjectContext.mr_default().rollback()
            print("\(TAG) Changes rolled back")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("\(TAG) Memory Warning received")
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections!.count
    }
    
    // ask the `NSFetchedResultsController` for the section
    override func tableView(_ tableView: UITableView,
        numberOfRowsInSection section: Int)
        -> Int {
            return self.fetchedResultsController.sections![section].numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionsInfo: AnyObject = self.fetchedResultsController.sections![section]
        
        switch (sectionsInfo.indexTitle!!) {
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
    override func tableView(_ tableView: UITableView,
        cellForRowAt indexPath: IndexPath)
        -> UITableViewCell {

            var reuseIdentifier: String!
            let row = self.fetchedResultsController.object(at: indexPath) as! Row
            
            if (row.section == "0") {
                reuseIdentifier = "TitleCell"
            } else if (row.section == "1") {
                reuseIdentifier = "ValueCell"
            } else {
//                if self.category?.name == "Note" {
//                    reuseIdentifier = "NoteCell2"
//                } else {
//                    reuseIdentifier = "NoteCell"
//                }
                (self.category?.name != "Note") ? (reuseIdentifier = "NoteCell") : (reuseIdentifier = "NoteCell2")
            }
            let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) 
            configureCell(cell, atIndexPath: indexPath)
            return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 68.0
        }
        return (category?.name != "Note") ? (44.0) : (250.0)
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "toEditAccountValuesTVCSegue", sender: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            cell.addSubview(Helper.seperatorTopImageView(cell))
        } else {
            cell.addSubview(Helper.seperatorTopImageView(cell))
            cell.addSubview(Helper.seperatorButtomImageView(cell))
        }
    }

    // MARK: - Fetched results controller
    
    var fetchedResultsController: NSFetchedResultsController<NSFetchRequestResult> {
        // return if already initialized
        if self._fetchedResultsController != nil {
            return self._fetchedResultsController!
        }

        let managedObjectContext = NSManagedObjectContext.mr_default()

        /* `NSFetchRequest` config */
        let entity = NSEntityDescription.entity(forEntityName: "Row", in: managedObjectContext)
        let sort = NSSortDescriptor(key: "section", ascending: true)
        let req = NSFetchRequest<NSFetchRequestResult>()
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
                //            default:
                //                return
            }
    }
    
    /* called last
    tells `UITableView` updates are complete */
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.tableView.endUpdates()
    }
    
    /* helper method to configure a `UITableViewCell`
    ask `NSFetchedResultsController` for the model */
    func configureCell(_ cell: UITableViewCell,
        atIndexPath indexPath: IndexPath) {
            
//            let sectionsInfo: AnyObject = self.fetchedResultsController.sections![indexPath.section]
            let row = self.fetchedResultsController.object(at: indexPath) as! Row
            
            switch (row.section/*indexPath.section*/) {
            case "0":
                let imageView = cell.contentView.subviews[0] as! UIImageView
                let titleLabel = cell.contentView.subviews[1].subviews[0] as! UILabel
                imageView.image = UIImage(named: row.key)
                titleLabel.text = row.value
                break;
            case "1":
                let keyLabel = cell.contentView.subviews[0] as! UILabel
                let valueLabel = cell.contentView.subviews[1] as! UILabel
                keyLabel.text = row.key
                valueLabel.text = row.value
                break;
            case "2":
                let noteLabel = cell.contentView.subviews[0] as! UILabel
                if row.value != "No Note" { noteLabel.textColor = UIColor.black }
                noteLabel.text = row.value
                break;
                
            default:
                break;
            }
    }
    
    // MARK: - EditValuesTableViewController Delegate
    
    func rowValueChanged() {
        
        let indexPath = self.tableView.indexPathForSelectedRow
        
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
        
        if let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath!)
        {
            configureCell(cell, atIndexPath: indexPath!)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toEditAccountValuesTVCSegue" {
            
            let row = self.fetchedResultsController.object(at: sender as! IndexPath) as! Row
            let targetVC = segue.destination as! EditValuesTableViewController
            
            targetVC.rowId = row.objectID
            targetVC.placeholder = row.value
            targetVC.delegate = self
            
            isBackTouched = false
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func saveBarButtonTouched(_ sender: UIBarButtonItem) {
        isBackTouched = false
        save()
        self.delegate?.newDataSaved()
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Helper Methods

    func save() {
        let managedObjectContext = NSManagedObjectContext.mr_default()

        // Backup changed rows before rollBack
        let fetchedRows = self.fetchedResultsController.fetchedObjects as! [Row]
        
        // Get name
        var name = String("")
        
        // Get Data
        let rows = rowsDictionaries(fetchedRows, name: &name!)
        
        // template deki degisiklikeri geri almak icin
        managedObjectContext.rollback()
        
        // Insert new entity for SavedObject
        let savedObject = NSEntityDescription
                                .insertNewObject(forEntityName: "SavedObject",
                                                into: managedObjectContext) as! SavedObject
        
        savedObject.name = name!
        savedObject.data = rows
        savedObject.date = Date()
        savedObject.type = self.type!
        savedObject.category = self.category!
        
        if self.type == nil || self.category == nil {
            print("\(TAG) nil kaydedildi.")
        }
        
        // Insert new rows
        for row in rows {
            let dict: Dictionary<String, String> = row
            
            let newRow = NSEntityDescription.insertNewObject(forEntityName: "Row",
                                                             into: managedObjectContext) as! Row
            
            if let key = dict["key"] {
                newRow.key = key
            } else { print("key is not in the dictionary") }
            
            if let value = dict["value"] {
                newRow.value = value
            } else { print("value is not in the dictionary") }
            
            if let section = dict["section"] {
                newRow.section = section
            } else { print("section is not in the dictionary") }
            
            newRow.savedObject = savedObject
            
            let manyRelation = savedObject.value(forKeyPath: "rows") as! NSMutableSet
            manyRelation.add(newRow)
        }

        var e: NSError?

        if !Constants.TEST {
            managedObjectContext.mr_saveToPersistentStoreAndWait()
        }
        
        if Constants.TEST {
            let req = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedObject")
            let fetchArray: [AnyObject]?
            do {
                fetchArray = try managedObjectContext.fetch(req)
            } catch let error as NSError {
                e = error
                fetchArray = nil
            }
            for savedObject in fetchArray as! [SavedObject] {
                let arr: Array = savedObject.data
                for a in arr {
                    print("\(TAG) \(a)")
                }
                
                print("")
            }
        }
    }
    
    func rowsDictionaries(_ rows: [Row], name: inout String) -> Array<Dictionary<String, String>> {
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
