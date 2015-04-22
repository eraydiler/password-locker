//
//  CreatePasswordViewController.swift
//  PasswordLockerSwift
//
//  Created by Eray on 21/04/15.
//  Copyright (c) 2015 Eray. All rights reserved.
//

import UIKit
import CoreData

class CreatePasswordViewController: UIViewController, UITextFieldDelegate {
    let kPasswordKey = "PassLock"
    
    @IBOutlet weak var passwordTextField: UITextField!
    var managedObjectContext: NSManagedObjectContext?
    
    func configureView() {
        self.passwordTextField.setValue(UIColor.grayColor(), forKeyPath: "_placeholderLabel.textColor")
        self.passwordTextField.tintColor = UIColor.grayColor()
        self.passwordTextField.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    
    @IBAction func addPassLockButtonPressed(sender: AnyObject) {
        
        if self.passwordTextField.text == "" { return }

        let isSaved: Bool = KeychainWrapper.setString(passwordTextField.text, forKey: kPasswordKey)
        if isSaved {
            println("Saved Successfully")
            
            // show alert
            let alertController = UIAlertController(title: "Password Saved", message: "Your password is saved successfully", preferredStyle: .Alert)
            
            let okAction = UIAlertAction(title: "OK", style: .Default, handler: { (alertAction) -> Void in
                self.performSegueWithIdentifier("toAuthenticationVCSegue", sender: self)
            })
            alertController.addAction(okAction)
            
            presentViewController(alertController, animated: true, completion: nil)
        }
        else { println("Error when saving") }
    }
    
    // MARK: - UITextField Delegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        if textField.text == "" { return false }
        
        let isSaved: Bool = KeychainWrapper.setString(passwordTextField.text, forKey: kPasswordKey)
        if isSaved {
            println("Saved Successfully")
            
            // show alert
            let alertController = UIAlertController(title: "Password Saved", message: "Your password is saved successfully", preferredStyle: .Alert)
            
            let okAction = UIAlertAction(title: "OK", style: .Default, handler: { (alertAction) -> Void in
                self.performSegueWithIdentifier("toAuthenticationVCSegue", sender: self)
            })
            alertController.addAction(okAction)
            
            presentViewController(alertController, animated: true, completion: nil)
        }
        else { println("Error when saving") }
        return false
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toAuthenticationVCSegue" {
            let authenticationVC = segue.destinationViewController as! AuthenticationViewController
            authenticationVC.managedObjectContext = self.managedObjectContext
        }
    }

}
