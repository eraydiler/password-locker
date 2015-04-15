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

class EditValuesTableViewController: UITableViewController, UITextViewDelegate {
    let TAG = "EditValuesTableViewController"

    @IBOutlet weak var editTextField: UITextField!
    @IBOutlet weak var editTextView: UITextView!
    
    @IBOutlet weak var textFieldCell: UITableViewCell!
    @IBOutlet weak var textViewCell: UITableViewCell!
    
    // set by AppDelegate on application startup
    var managedObjectContext: NSManagedObjectContext?

    var placeholder: String?
    var rowId: NSManagedObjectID?
    var row: Row?
    
    // delegate to send value to former controller
    var delegate: EditValuesTableViewControllerDelegate! = nil
    
    func configureView() {
        
        self.tableView.allowsSelection = false
        
        self.tableView.rowHeight = 44.0
        self.row = self.managedObjectContext?.objectWithID(self.rowId!) as? Row
        
        self.title = "Edit"
        
//        if self.row?.value == "" {
//            self.editTextField.placeholder = self.row?.key
//        } else {
//            self.editTextField.text = self.row?.value
//        }
//        self.editTextField.text = placeholder
        // Check if it is note
        if self.row?.section == "2" {
            //            let frameRect = editTextField.frame
            //            frameRect.size.height = 10.0
            //            editTextField.frame = frameRect
            
            self.textViewCell.hidden = false
            self.textFieldCell.hidden = true
            configureTextView()
        } else {
            self.textViewCell.hidden = true
            self.textFieldCell.hidden = false
            configureTextField()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
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
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 2
    }
    
    @IBAction func doneBarButtonPressed(sender: UIBarButtonItem) {
        
        var newValue = String("")
        
        if self.row?.section != "2" { newValue = editTextField.text }
        else { newValue = editTextView.text }
        
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
        self.editTextView?.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height - keyboardHeight-200)
    }
    
    // MARK: - Helper Methods
    
    func configureTextField() {
        
        if self.row?.value == "" {
            self.editTextField.placeholder = self.row?.key
        } else {
            self.editTextField.text = self.row?.value
        }
        self.editTextField.text = placeholder
    }
    
    func configureTextView() {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidShow:", name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardDidHide:", name: UIKeyboardDidHideNotification, object: nil)
        
        if self.row?.value == "" {
            self.editTextView.text = "No Note"
        } else {
            self.editTextView.text = self.row?.value
        }
    }
}
