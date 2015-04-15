//
//  EditNoteTableViewController.swift
//  PasswordLockerSwift
//
//  Created by Eray on 23/03/15.
//  Copyright (c) 2015 Eray. All rights reserved.
//

import UIKit
import CoreData

protocol EditNoteTableViewControllerDelegate {
    func rowValueChanged()
}

class EditNoteTableViewController: UITableViewController, UITextFieldDelegate {
        
    // set by AppDelegate on application startup
    var managedObjectContext: NSManagedObjectContext?
    
    var rowId: NSManagedObjectID?
    var row: Row?
    var scrollView: UIScrollView?
    var editText: UITextField?
    var textView: UITextView?
    
    // delegate to send value to former controller
    var delegate: EditValuesTableViewControllerDelegate! = nil
    
    func configureView() {
        self.title = "Edit"
        self.row = self.managedObjectContext?.objectWithID(self.rowId!) as? Row
        self.tableView.rowHeight = 44.0
        
        if row?.section == "2" {
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidShow:", name: UIKeyboardDidShowNotification, object: nil)
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidHide:", name: UIKeyboardDidHideNotification, object: nil)
        }
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
        println("did receive memory warning")
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
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var reuseIdentifier: String!
        if row?.section == "0" {
            reuseIdentifier = "TitleCell"
        } else {
            reuseIdentifier = "NoteCell"
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        self.configureCell(cell, atIndexPath: indexPath, forOption: reuseIdentifier)

        return cell
    }
    
    /* helper method to configure a `UITableViewCell`
    ask `NSFetchedResultsController` for the model */
    func configureCell(cell: UITableViewCell,
        atIndexPath indexPath: NSIndexPath,
        forOption option: String) {
            
            if option == "TitleCell" {
                self.editText = cell.contentView.subviews[0] as? UITextField
                self.editText?.text = row?.value
            } else {
                let scrollView = cell.contentView.subviews[0] as? UIScrollView
                self.scrollView = scrollView
                self.scrollView?.delegate = self
                
                self.textView = cell.contentView.subviews[0].subviews[0] as? UITextView
                self.textView?.text = row?.value
            }
    }
    
    // MARK: - IBActions
    @IBAction func doneBarButtonPressed(sender: UIBarButtonItem) {
        
        var newValue: String!
        (self.row?.section == "0") ? (newValue = self.editText?.text) : (newValue = self.textView?.text)
        self.row?.value = newValue
        
        delegate.rowValueChanged()
        
        self.navigationController?.popViewControllerAnimated(true)

    }
    
    // MARK: - UITextField Delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    // MARK: - Keyboard Notifications
    
    func keyboardDidShow(notification: NSNotification) {
        if let rectValue = notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue {
            let keyboardSize = rectValue.CGRectValue().size
            updateTextViewSizeForKeyboardHeight(keyboardSize.height)
        }
    }
    
    func keyboardDidHide(notification: NSNotification) {
        updateTextViewSizeForKeyboardHeight(0)
    }
    
    func updateTextViewSizeForKeyboardHeight(keyboardHeight: CGFloat) {
        self.textView?.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - keyboardHeight-150)
    }
}
