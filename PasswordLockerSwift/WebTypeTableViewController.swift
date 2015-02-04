//
//  WebTypeTableViewController.swift
//  PasswordLockerSwift
//
//  Created by Eray on 03/02/15.
//  Copyright (c) 2015 Eray. All rights reserved.
//

import UIKit

class WebTypeTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.tableView.rowHeight = 45
        self.navigationItem.title = "Type"
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
        return 13
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("toWebTVCSegue", sender: indexPath)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        if segue.identifier == "toWebTVCSegue" {
            let targetVC = segue.destinationViewController as WebTableViewController
            
            let cell: UITableViewCell = self.tableView.cellForRowAtIndexPath(sender as NSIndexPath)!
            
            let titleLabel: UILabel = cell.viewWithTag(1) as UILabel
            let iconImageView: UIImageView = cell.viewWithTag(2) as UIImageView
            
            targetVC.titleName = titleLabel.text
            targetVC.iconImage = iconImageView.image
        }
    }    
}
