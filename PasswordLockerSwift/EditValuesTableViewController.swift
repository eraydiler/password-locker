//
//  EditValuesTableViewController.swift
//  PasswordLockerSwift
//
//  Created by Eray on 18/03/15.
//  Copyright (c) 2015 Eray. All rights reserved.
//

import UIKit
import CoreData

protocol EditValuesTableViewControllerDelegate {
    func rowValueChanged()
}

class EditValuesTableViewController: UITableViewController {

    @IBOutlet weak var editTextField: UITextField!
    
    // set by AppDelegate on application startup
    var managedObjectContext: NSManagedObjectContext?

    var placeholder: String?
    var rowId: NSManagedObjectID?
    var row: Row?
    
    // delegate to send value to former controller
    var delegate: EditValuesTableViewControllerDelegate! = nil
    
    func configureView() {
        
        self.tableView.rowHeight = 44.0
        self.row = self.managedObjectContext?.objectWithID(self.rowId!) as? Row
        
        self.title = "Edit"
        
        if self.row?.value == "" {
            self.editTextField.placeholder = self.row?.key
        } else {
            self.editTextField.text = self.row?.value
        }
        self.editTextField.text = placeholder
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
    
    @IBAction func doneBarButtonPressed(sender: UIBarButtonItem) {
        
        let newValue = editTextField.text
        self.row?.value = newValue
        
        delegate.rowValueChanged()
        self.navigationController?.popViewControllerAnimated(true)
    }    
}
