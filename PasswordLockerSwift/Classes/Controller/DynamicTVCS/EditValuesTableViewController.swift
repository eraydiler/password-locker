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

    var placeholder: String?
    var rowId: NSManagedObjectID?
    var row: Row?
    
    // delegate to send value to former controller
    var delegate: EditValuesTableViewControllerDelegate! = nil
    
    func configureView() {
        
        self.tableView.allowsSelection = false
        
        self.tableView.rowHeight = 44.0

        self.row = NSManagedObjectContext.mr_default().object(with: self.rowId!) as? Row
        
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
            
            self.textViewCell.isHidden = false
            self.textFieldCell.isHidden = true
            configureTextView()
        } else {
            self.textViewCell.isHidden = true
            self.textFieldCell.isHidden = false
            configureTextField()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("\(TAG) memory warning", terminator: "")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 2
    }
    
    @IBAction func doneBarButtonPressed(_ sender: UIBarButtonItem) {
        
        var newValue = ""
        
        if self.row?.section != "2" { newValue = editTextField.text! }
        else { newValue = editTextView.text }
        
        self.row?.value = newValue
        
        delegate.rowValueChanged()
        _ = self.navigationController?.popViewController(animated: true)
    }
        
    // MARK: - UITextField Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    // MARK: - Keyboard Notifications
    
    @objc func keyboardDidShow(_ notification: Notification) {
        if let rectValue = notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue {
            let keyboardSize = rectValue.cgRectValue.size
            updateTextViewSizeForKeyboardHeight(keyboardSize.height)
        }
    }
    
    @objc func keyboardDidHide(_ notification: Notification) {
        updateTextViewSizeForKeyboardHeight(0)
    }
    
    func updateTextViewSizeForKeyboardHeight(_ keyboardHeight: CGFloat) {
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
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardDidShow),
            name: UIResponder.keyboardDidShowNotification,
            object: nil)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardDidHide),
            name: UIResponder.keyboardDidHideNotification,
            object: nil)
        
        if self.row?.value == "" {
            self.editTextView.text = "No Note"
        } else {
            self.editTextView.text = self.row?.value
        }
    }
}
