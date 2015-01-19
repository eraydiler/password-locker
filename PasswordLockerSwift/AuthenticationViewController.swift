//
//  AuthenticationViewController.swift
//  PasswordLockerSwift
//
//  Created by Eray on 19/01/15.
//  Copyright (c) 2015 Eray. All rights reserved.
//

import UIKit

class AuthenticationViewController: UIViewController, UITextFieldDelegate, UIAlertViewDelegate {
    @IBOutlet weak var passwordTextField: UITextField!
    
    let kPasswordKey="PassLock";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        passwordTextField.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    @IBAction func addPassLockButtonPressed(sender: AnyObject) {
        let isSaved: Bool = KeychainWrapper.setString(passwordTextField.text, forKey: kPasswordKey)
        if isSaved {
            NSLog("Saved Successfully")
            
            // show alert
            let alertController = UIAlertController(title: "Password Saved", message: "Your password is saved successfully", preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            
            presentViewController(alertController, animated: true, completion: nil)
        }
        else { NSLog("Error when saving") }

    }
    
    @IBAction func deletePassLockButtonPressed(sender: AnyObject) {
        let isRemoved: Bool = KeychainWrapper.removeObjectForKey(kPasswordKey)
        if isRemoved {
            NSLog("Removed Successfully")
            
            // show alert
            let alertController = UIAlertController(title: "Password Removed", message: "Your password is removed successfully", preferredStyle: .Alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            
            presentViewController(alertController, animated: true, completion: nil)
        }
        else {
            NSLog("Error when removing")
        }
    }
    
    @IBAction func checkButtonPressed(sender: AnyObject) {
        let retrieveString: String? = KeychainWrapper.stringForKey(kPasswordKey)
        NSLog("\(retrieveString)")
    }
    
    @IBAction func viewTapped(sender: AnyObject) {
        NSLog("View Tapped")
        passwordTextField.resignFirstResponder()
    }
    
    // MARK: - UITextField Delegate
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.isEqual(passwordTextField) {
            let retrieveString: String? = KeychainWrapper.stringForKey(kPasswordKey)
            if retrieveString == passwordTextField.text {
                // Success
                NSLog("Login Successful")
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
        }
    }
}

