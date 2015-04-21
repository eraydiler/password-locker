//
//  AuthenticationViewController.swift
//  PasswordLockerSwift
//
//  Created by Eray on 19/01/15.
//  Copyright (c) 2015 Eray. All rights reserved.
//

import UIKit
import CoreData

class AuthenticationViewController: UIViewController, UITextFieldDelegate, UIAlertViewDelegate {
    let TAG = "AuthenticationViewController"
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    var managedObjectContext: NSManagedObjectContext?
    
    let kPasswordKey = "PassLock"
    
    func configureView() {
        passwordTextField.delegate = self
        self.passwordTextField.setValue(UIColor.grayColor(), forKeyPath: "_placeholderLabel.textColor")
        self.passwordTextField.tintColor = UIColor.whiteColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    @IBAction func addPassLockButtonPressed(sender: AnyObject) {
        let isSaved: Bool = KeychainWrapper.setString(passwordTextField.text, forKey: kPasswordKey)
        if isSaved {
            println("Saved Successfully")
            
            // show alert
            let alertController = UIAlertController(title: "Password Saved", message: "Your password is saved successfully", preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            
            presentViewController(alertController, animated: true, completion: nil)
        }
        else { println("Error when saving") }

    }
    
    @IBAction func deletePassLockButtonPressed(sender: AnyObject) {
        let isRemoved: Bool = KeychainWrapper.removeObjectForKey(kPasswordKey)
        if isRemoved {
            println("Removed Successfully")
            
            // show alert
            let alertController = UIAlertController(title: "Password Removed", message: "Your password is removed successfully", preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: { (alertAction) -> Void in
                self.dismissViewControllerAnimated(true, completion: nil)
            })

            alertController.addAction(defaultAction)
            presentViewController(alertController, animated: true, completion: nil)            
            
        }
        else {
            println("Error when removing")
        }
    }
    /*
    let alertView = UIAlertController(title: "You need to log in first", message: "To access the special features of the app you need to log in first.", preferredStyle: .Alert)
    alertView.addAction(UIAlertAction(title: "Login", style: .Default, handler: { (alertAction) -> Void in
    logUserIn()
    }))
    alertView.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
    presentViewController(alertView, animated: true, completion: nil)
    */
    
    @IBAction func checkButtonPressed(sender: AnyObject) {
        let retrieveString: String? = KeychainWrapper.stringForKey(kPasswordKey)
        println("\(retrieveString)")
    }
    
    @IBAction func viewTapped(sender: AnyObject) {
        passwordTextField.resignFirstResponder()
    }
    
    // MARK: - UITextField Delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.isEqual(passwordTextField) {
            let retrieveString: String? = KeychainWrapper.stringForKey(kPasswordKey)
            if retrieveString == passwordTextField.text {
                // Success
                println("Login Successful")
                self.performSegueWithIdentifier("AuthenticationToTabBarController", sender: nil)
                return true
            } else {
                // show alert
                let alertController = UIAlertController(title: "Wrong Pass", message: "Be sure to enter right password", preferredStyle: .Alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
                alertController.addAction(defaultAction)
                
                presentViewController(alertController, animated: true, completion: nil)
            }
        }
        return false
    }
    
    // MARK: - Navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "AuthenticationToTabBarController" {
            // Set managedObjectContext for view controllers
            let tabBarController = segue.destinationViewController as! TabBarController
            tabBarController.managedObjectContext = self.managedObjectContext
            
            let nav = tabBarController.childViewControllers[0] as! UINavigationController
            let categoriesVC = nav.topViewController as! CategoriesTableViewController
            categoriesVC.managedObjectContext = self.managedObjectContext
        }
    }
    
    // Helper Methods
    func checkPassword() -> Bool {
        return (KeychainWrapper.stringForKey(kPasswordKey) != nil)
    }
}

