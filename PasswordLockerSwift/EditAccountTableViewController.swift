//
//  EditAccountTableViewController.swift
//  PasswordLockerSwift
//
//  Created by Eray on 05/02/15.
//  Copyright (c) 2015 Eray. All rights reserved.
//

import UIKit

class EditAccountTableViewController: UITableViewController {
    
    @IBOutlet weak var editTextField: UITextField!
    var placeholder: String?


    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.editTextField.placeholder = self.placeholder
        self.tableView.rowHeight = 45
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 1
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("toEditAccountTVCSegue", sender: indexPath)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "toEditAccountTVCSegue" {
            let targetVC = segue.destinationViewController as EditWebTableViewController
            targetVC.placeholder = getPlaceholder(sender as NSIndexPath)
        }
    }
    
    // MARK: - Helper Methods
    func getPlaceholder(indexPath: NSIndexPath) -> String {
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 { return "Database" }
            else if indexPath.row == 1 { return "ID" }
            else { return "Password" }
            
        default:
            return "Notes"
        }
    }
}
