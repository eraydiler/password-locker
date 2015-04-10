//
//  SelectedValuesTableViewController.swift
//  PasswordLockerSwift
//
//  Created by Eray on 08/04/15.
//  Copyright (c) 2015 Eray. All rights reserved.
//

import UIKit
import CoreData

class SelectedValuesTableViewController: UITableViewController {
    let TAG = "SelectedValuesTableViewController"
    
    // set by former controller
    var category: Category?
    var savedObjectID: NSManagedObjectID?
    var savedObject: SavedObject?
    var rows: Array<Dictionary<String, String>>?
    
    // set by AppDelegate on application startup
    var managedObjectContext: NSManagedObjectContext?

    func configureView() {
        self.savedObject = self.managedObjectContext?.objectWithID(self.savedObjectID!) as? SavedObject
        self.rows = self.savedObject?.data
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("\(TAG) memory warning")
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 3
        
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.rows!.count
    }
    
    /* helper method to configure a `UITableViewCell`
    ask `NSFetchedResultsController` for the model */
    func configureCell(cell: UITableViewCell,
        atIndexPath indexPath: NSIndexPath) {
            
            let row = self.rows?[indexPath.row]
            
            
//            switch (indexPath.section) {
//            case 0:
//                let imageView = cell.contentView.subviews[0] as UIImageView
//                var titleLabel = cell.contentView.subviews[1].subviews[0] as UILabel
//                imageView.image = UIImage(named: row.key)
//                titleLabel.text = row.value
//                break;
//            case 1:
//                var keyLabel = cell.contentView.subviews[0] as UILabel
//                var valueLabel = cell.contentView.subviews[1] as UILabel
//                keyLabel.text = row.key
//                valueLabel.text = row.value
//                break;
//            case 2:
//                var noteLabel = cell.contentView.subviews[0] as UILabel
//                noteLabel.text = row.value
//                break;
//                
//            default:
//                break;
//            }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let indexPath = self.tableView.indexPathForSelectedRow()
//        let row = self.rows[indexPath?.row]
        
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
    
    func parseDataForTitle(data: Array<Dictionary<String, String>>,
        atIndexPath indexPath: NSIndexPath) -> String {
            
            var title: String = String()
            let dict: Dictionary<String, String> = data[indexPath.row]
            
            if indexPath.section == 0 {
                title = dict["value"]!
            }
            
            for (key, value) in dict {
                println("\(TAG) key: \(key), value: \(value)")
            }
            
            return title
    }
}
