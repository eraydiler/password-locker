//
//  LoginEditTableViewController.swift
//  PasswordLockerSwift
//
//  Created by Eray on 21/01/15.
//  Copyright (c) 2015 Eray. All rights reserved.
//

import UIKit
import CoreData

class LoginEditTableViewController: UITableViewController {
    
    @IBOutlet weak var saveBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var addNewFieldBarButtonItem: UIBarButtonItem!
    
    let TAG = "LoginEditViewController"
    let HeaderCellIdentifier = "Header Cell"
    let FieldCellIdentifier = "Field Cell"

    var loginModel: LoginModel?
    var fields = [LoginModelField]()
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    
    var isSavePressed: Bool = false
    var isEmptyFieldExists: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Setting edit
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.navigationItem.rightBarButtonItem?.action = "editAction"
        
        self.tableView.rowHeight = 45
        
//        self.saveBarButtonItem.enabled = false
    }
    
    override func viewWillAppear(animated: Bool) {
        
        // Make a fetch request to get related data from Core Data
        let fetchRequest = NSFetchRequest(entityName: "LoginModelField")
        
        // Sort data by rowIndex
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "rowIndex", ascending: true)]
        
        // Only get fields related to the loginModel.name = self.loginModel.name
        fetchRequest.predicate = NSPredicate(format: "loginModel.name == %@", self.loginModel!.name)
        
        var error: NSError? = nil
        let fetchedFields = managedObjectContext?.executeFetchRequest(fetchRequest, error: &error) as [LoginModelField]?
        
        // Log the error
        if error != nil { println("\(TAG) \(error?.localizedDescription)") }
        
        // Assign the data got from Core Data to self.fields
        self.fields = fetchedFields!
        
        // disable save button if there is no data at all
        if (self.fields.count == 0) { self.saveBarButtonItem.enabled = false }
        
        // Test
        for element in self.fields {
            let field = element as LoginModelField
            println("\(field.key) \(field.value)")
        }
        
        // Reload self.tableView with data from Core Data
        self.tableView .reloadData()
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
        return self.fields.count
    }
    
    // MARK: - Table view delegate
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier(HeaderCellIdentifier) as UITableViewCell
        
        let titleLabel: UILabel = headerCell.viewWithTag(3) as UILabel
        titleLabel.text = self.loginModel!.name
        
        var headerView = headerCell.viewWithTag(1)
        return headerView
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(FieldCellIdentifier, forIndexPath: indexPath) as UITableViewCell
        
        // Get cell data
        var field: LoginModelField = self.fields[indexPath.row]
        
        // hücre içindeki alanların taglarına deger verdim, label:1 textfield:2, viewWithTag ile ulaşılıyor.
        var keyTextField: UITextField = cell .viewWithTag(1) as UITextField
        var valueTextField: UITextField = cell .viewWithTag(2) as UITextField
        
        if isSavePressed {
            
            // If save button is pressed get data from textFields
            field.key = keyTextField.text
            field.value = valueTextField.text
            field.rowIndex = indexPath.row as NSNumber
            
            // Update fields array
            self.fields[indexPath.row] = field
            
            // If there is an empty field
            if keyTextField.text == "" || valueTextField.text == "" {self.isEmptyFieldExists = true}
            else { self .saveKeyAndValueAtIndexPath(indexPath) }
            
            // If it is the last row
            if indexPath.row == self.fields.count-1 {
                
                // Restore save button state
                self.isSavePressed = false
                
                // If there is an empty field show alert
                if self.isEmptyFieldExists { self .showWarning("Warning", message: "Just remember that empty fields will not be saved") }
                else { self .showWarning("Warning", message: "Data saved successfully") }
                
                // TEST
                println("Test fields array is")
                for test in self.fields { println("key: \(test.key) value: \(test.value)") }
            }
        } else {
            
            // When save button does not pressed get data from fields array to textFields
            keyTextField.text = field.key
            valueTextField.text = field.value
        }
        
        (tableView.editing) ? (keyTextField.enabled = false) : (keyTextField.enabled = true);
        (tableView.editing) ? (valueTextField.enabled = false) : (valueTextField.enabled = true);

        return cell
    }

    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - IBActions
    
    func editAction() {
        
        if self.tableView.editing {
            self.navigationItem.rightBarButtonItem?.title = "Edit"
            self.addNewFieldBarButtonItem.enabled = false
            if self.fields.count > 0 { self.saveBarButtonItem.enabled = true }
            self.tableView .setEditing(false, animated: true)
            self.tableView .reloadData()
        } else {
            self.navigationItem.rightBarButtonItem?.title = "Done"
            self.addNewFieldBarButtonItem.enabled = true
            self.saveBarButtonItem.enabled = false
            self.tableView .setEditing(true, animated: true)
            self.tableView .reloadData()
        }
    }
    
    @IBAction func saveButtonPressed(sender: UIBarButtonItem) {
        self.isSavePressed = true
        self.tableView .reloadData()
    }

    @IBAction func addNewFieldPressed(sender: UIBarButtonItem) {
        self.tableView .beginUpdates()
        let entity = NSEntityDescription .entityForName("LoginModelField", inManagedObjectContext: managedObjectContext!)
        let field: LoginModelField = LoginModelField(entity: entity!, insertIntoManagedObjectContext: nil)
        field.key = ""
        field.value = ""
        self.fields .append(field)
        
        // Insert new cell to the tableview
        self.tableView .insertRowsAtIndexPaths([NSIndexPath(forRow: self.fields.count-1, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Fade)
    
        // Scroll tableView to the field newly created.
//        self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: self.fields.count-1, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: true)
        self.tableView .endUpdates()
    }
    
    // MARK: - Helper Methods
    
    func saveKeyAndValueAtIndexPath(indexPath: NSIndexPath) {
        
        // Get fields from Core Data into results nsarray
        var fetchRequest = NSFetchRequest(entityName: "LoginModelField")
        fetchRequest.predicate = NSPredicate(format: "loginModel.name == %@", self.loginModel!.name)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "rowIndex", ascending: true)]
        
        var error: NSError? = nil
        let results = managedObjectContext?.executeFetchRequest(fetchRequest, error: &error)
        
        // Log the error
        if error != nil {
            println("\(self.TAG) \(error?.localizedDescription)")
            return
        } else {
            
            // Get instant data from fields array
            var field = self.fields[indexPath.row]
            
            // Update
            if results?.count > indexPath.row {
                
                var fieldUpdating = results![indexPath.row] as LoginModelField
                fieldUpdating.key = field.key
                fieldUpdating.value = field.value
                fieldUpdating.rowIndex = indexPath.row as NSNumber
                
                if managedObjectContext! .save(&error) {
                    println("\(self.TAG) \(error?.localizedDescription)")
                }
                
                // update fields property
                self.fields[indexPath.row] = fieldUpdating
            } else {
                
                // Check if core data have the same data
                let alreadyExists = self .containsData(results as [LoginModelField], withKey: field.key, andValue: field.value)
            
                // Duplication
                if alreadyExists {
                    self .showWarning("Warning", message: "Field already exists")
                    return
                }
                
                // Create new
                field = LoginModelField .loginFieldWithName(self.loginModel!, keyAndValue: (field.key, field.value), atIndexPath: indexPath)
                self.fields .append(field)
            }
        }
    }
    
    func containsData(fields: [LoginModelField], withKey key: String, andValue value: String) -> Bool {
        
        for field in fields {
            if field.key == key && field.value == value { return true }
        }
        return false
    }
    
    func showWarning(title: String, message: String) {
        var alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert .addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self .presentViewController(alert, animated: true, completion: nil)
    }
}
