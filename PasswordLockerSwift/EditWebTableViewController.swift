//
//  EditWebTableViewController.swift
//  PasswordLockerSwift
//
//  Created by Eray on 04/02/15.
//  Copyright (c) 2015 Eray. All rights reserved.
//

import UIKit

class EditWebTableViewController: UITableViewController {
    
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
}
