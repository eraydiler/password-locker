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
    
//    var managedObjectContext: NSManagedObjectContext?

    let kPasswordKey = "PassLock"
    
    func configureView() {
        passwordTextField.delegate = self
        self.passwordTextField.setValue(UIColor.gray, forKeyPath: "_placeholderLabel.textColor")
        self.passwordTextField.tintColor = UIColor.white
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
    @IBAction func addPassLockButtonPressed(_ sender: AnyObject) {
        let isSaved: Bool = KeychainWrapper.setString(passwordTextField.text!,
                                                      forKey: kPasswordKey)
        if isSaved {
            print("Saved Successfully")
            
            // show alert
            let alertController = UIAlertController(title: "Password Saved",
                                                    message: "Your password is saved successfully",
                                                    preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
        }
        else { print("Error when saving") }

    }
    
    @IBAction func deletePassLockButtonPressed(_ sender: AnyObject) {
        let isRemoved: Bool = KeychainWrapper.removeObjectForKey(kPasswordKey)
        if isRemoved {
            print("Removed Successfully")
            
            // show alert
            let alertController = UIAlertController(title: "Password Removed", message: "Your password is removed successfully", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { (alertAction) -> Void in
                self.dismiss(animated: true, completion: nil)
            })

            alertController.addAction(defaultAction)
            present(alertController, animated: true, completion: nil)            
            
        }
        else {
            print("Error when removing")
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
    
    @IBAction func checkButtonPressed(_ sender: AnyObject) {
        let retrieveString: String? = KeychainWrapper.stringForKey(kPasswordKey)
        print("\(retrieveString)")
    }
    
    @IBAction func viewTapped(_ sender: AnyObject) {
        passwordTextField.resignFirstResponder()
    }
    
    // MARK: - UITextField Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.isEqual(passwordTextField) {
            let retrieveString: String? = KeychainWrapper.stringForKey(kPasswordKey)
            if retrieveString == passwordTextField.text {
                // Success
                print("Login Successful")
                self.performSegue(withIdentifier: "AuthenticationToTabBarController", sender: nil)
                return true
            } else {
                // show alert
                let alertController = UIAlertController(title: "Wrong Pass", message: "Be sure to enter right password", preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alertController.addAction(defaultAction)
                
                present(alertController, animated: true, completion: nil)
            }
        }
        return false
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AuthenticationToTabBarController" {
            // Set managedObjectContext for view controllers
//            let tabBarController = segue.destination as! TabBarController
//            tabBarController.managedObjectContext = managedObjectContext
//            
//            let nav = tabBarController.childViewControllers[0] as! UINavigationController
//            let categoriesVC = nav.topViewController as! CategoriesTableViewController
//            categoriesVC.managedObjectContext = self.managedObjectContext

            passwordTextField.text = nil
        }
    }
    
    // Helper Methods
    func checkPassword() -> Bool {
        return (KeychainWrapper.stringForKey(kPasswordKey) != nil)
    }
}

