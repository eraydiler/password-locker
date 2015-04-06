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
            rollBack()
            println("Changes rolled back")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        println("Memory Warning received")
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
//            var cell: UITableViewCell = UITableViewCell()
            var reuseIdentifier: String!
            
            if (indexPath.section == 0) {
                reuseIdentifier = "TitleCell"
            } else if (indexPath.section == 1) {
                reuseIdentifier = "ValueCell"
            } else {
                reuseIdentifier = "NoteCell"
            }
            var cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as UITableViewCell
            self.configureCell(cell, atIndexPath: indexPath)
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
        
    // MARK: - Fetched results controller
    
    // set by AppDelegate on application startup
    var managedObjectContext: NSManagedObjectContext?
    
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
        req.predicate = NSPredicate(format: "ANY types == %@", self.type!)
        
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
        atIndexPath indexPath: NSIndexPath,
        forChangeType type: NSFetchedResultsChangeType,
        newIndexPath: NSIndexPath) {
            switch type {
            case .Insert:
                self.tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Fade)
                println("coredata insert")
            case .Update:
                let cell = self.tableView.cellForRowAtIndexPath(indexPath)
                self.configureCell(cell!, atIndexPath: indexPath)
                self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                println("coredata update")
            case .Move:
                println("coredata move")
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                self.tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Fade)
            case .Delete:
                println("coredata delete")
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
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
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "toEditAccountValuesTVCSegue" {
            
            let row = self.fetchedResultsController.objectAtIndexPath(sender as NSIndexPath) as Row
            let targetVC = segue.destinationViewController as EditValuesTableViewController
            
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
//        addNewBar()
        self.delegate?.newDataSaved()
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func backBarButtonTouched(sender: UIBarButtonItem) {
        println("back clicked")
    }
    
    // MARK: - Helper Methods
    
    func rollBack() {
        managedObjectContext?.rollback()
    }
    
    func save() {
        
        // backup changed rows before rollBack
        let rows = self.fetchedResultsController.fetchedObjects as [Row]
        
        // Get Data
        let arr = dictionaryForModifiedType(rows)
        
        // template deki degisiklikeri geri almak icin
        rollBack()
        
        // Insert new entity for SavedData
        var newData = NSEntityDescription.insertNewObjectForEntityForName("SavedData", inManagedObjectContext: self.managedObjectContext!) as SavedData
        newData.data = arr
        newData.type = self.type!
        newData.date = NSDate()
        
        var e: NSError?

        if !Constants.TEST {
            if !managedObjectContext!.save(&e) {
                println("save error: \(e!.localizedDescription)")
                abort()
            }
        }
        
        if Constants.TEST {
            let req = NSFetchRequest(entityName: "SavedData")
            let fetchArray  = self.managedObjectContext?.executeFetchRequest(req, error: &e)
            for savedData in fetchArray as [SavedData] {
                let arr: Array = savedData.data
                for a in arr {
                    println(a)
                }
                println()
            }
        }
    }
    
    func dictionaryForModifiedType(rows: [Row]) -> Array<Dictionary<String, String>> {
        var dict = [String:String]()
        var arr = [Dictionary<String, String>]()
        
        for row in rows {
            dict["key"] = row.key
            dict["value"] = row.value
            arr.append(dict)
        }
        return arr
    }
    
    func addNewBar() {
        
        // Select viewcontroller from storyboard
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        var newUIView = storyBoard.instantiateViewControllerWithIdentifier("selectedTypeView") as SelectedTypeTableViewController
        
        // Set tab bar item
        newUIView.tabBarItem = UITabBarItem(title: self.category!.name, image: UIImage(named: "tab_\(self.category!.imageName)"), selectedImage: nil)
        
        // Set views's properties
        newUIView.category = self.category
        newUIView.managedObjectContext = self.managedObjectContext
        
        // Add view to tabs
        var tabs = self.tabBarController?.viewControllers
        tabs?.append(newUIView)
        self.tabBarController?.setViewControllers(tabs!, animated: true)        
    }
}
