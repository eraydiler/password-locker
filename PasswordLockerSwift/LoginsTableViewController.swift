//
//  LoginsTableViewController.swift
//  PasswordLockerSwift
//
//  Created by Eray on 20/01/15.
//  Copyright (c) 2015 Eray. All rights reserved.
//

import UIKit
import CoreData

class LoginsTableViewController: UITableViewController {

    var loginModels = [Any]()
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
    let CellIdentifier = "Login Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func viewWillAppear(animated: Bool) {
        
        // Make a fetch request to get related data from Core Data
        let fetchRequest = NSFetchRequest(entityName: "LoginModel")
        
        // Sort data by rowIndex
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "rowIndex", ascending: true)]
        
        // If an error occurs assign it to error variable.
        var error: NSError?
        let fetchedLoginModels = managedObjectContext?.executeFetchRequest(fetchRequest, error: &error)
        
        if let results = fetchedLoginModels {
            loginModels = results
        } else {
            println("Could not fetched \(error), \(error!.userInfo)")
        }
        self.tableView.reloadData()
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
        return self.loginModels.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier, forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        let loginModel: LoginModel? = self.loginModels[indexPath.row] as? LoginModel
        if loginModel != nil {
            cell.textLabel?.text = loginModel?.name
            cell.detailTextLabel?.text = self.stringFromDate(loginModel!.date)
        }
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Right)
        }    
    }

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
    @IBAction func addBarButtonPressed(sender: AnyObject) {
        
        // 1. Create the alert controller.
        var alert = UIAlertController(title: "Some Title", message: "Enter a text", preferredStyle: .Alert)
        
        // 2. Add the text field. You can configure it however you need.
        alert.addTextFieldWithConfigurationHandler({ (textField) -> Void in
            textField.placeholder = "New Login"
        })
        
        // 3. Add cancel button
        alert.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil))
        
        // 4. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (action) -> Void in
            
            // Get the text in alertView 's textField
            let loginModelName = (alert.textFields![0] as UITextField).text

            // Instant indexPath
            var indexPath = NSIndexPath(forRow: self.loginModels.count, inSection: 0)
            
            // Create new loginModel in the Core Data
            let login = self.loginMoldelWithName(loginModelName, atIndexPath: indexPath)

            // Add new loginModel to loginModels array
            self.loginModels.append(login)
            
            // indexPath is changed
            indexPath = NSIndexPath(forRow: self.loginModels.count-1, inSection: 0)
            
            // Add new loginModel into tableView
            self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }))
        
        // 5. Present the alert.
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func quitBarButtonPressed(sender: AnyObject) {
        let authenticationVC: AnyObject? = self.storyboard?.instantiateViewControllerWithIdentifier("AuthenticationID")
        self.presentViewController(authenticationVC as UIViewController, animated: true, completion: nil)
        
        if (self.presentedViewController?.isBeingDismissed() == true) {
            self.dismissViewControllerAnimated(true, completion: { () -> Void in
                // buraya nedense girmiyor
                println("logout")
            })
        }
    }
    
    // MARK: Helper Methods
    func loginMoldelWithName(name: NSString, atIndexPath indexPath: NSIndexPath) -> LoginModel {
        
        let login = NSEntityDescription.insertNewObjectForEntityForName("LoginModel", inManagedObjectContext: self.managedObjectContext!) as LoginModel
        
        login.name = name;
        login.date = NSDate()
        login.rowIndex = indexPath.row as NSNumber
        
        var error: NSError?
        
        if !managedObjectContext!.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
        
        return login
    }
    
    func stringFromDate(date: NSDate) -> String {
        var formatter: NSDateFormatter = NSDateFormatter()
        formatter.dateFormat = "dd/mm/yy hh:mm"
        let dateString = formatter.stringFromDate(date)
        return dateString
    }
}
