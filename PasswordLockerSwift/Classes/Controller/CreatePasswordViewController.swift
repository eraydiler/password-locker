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

    func configureView() {
        self.passwordTextField.setValue(UIColor.gray, forKeyPath: "_placeholderLabel.textColor")
        self.passwordTextField.tintColor = UIColor.gray
        self.passwordTextField.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - IBActions
    
    @IBAction func addPassLockButtonPressed(_ sender: AnyObject) {
        
        if self.passwordTextField.text == "" { return }

        let isSaved: Bool = KeychainWrapper.setString(passwordTextField.text!, forKey: kPasswordKey)
        if isSaved {
            print("Saved Successfully")
            
            // show alert
            let alertController = UIAlertController(title: "Password Saved", message: "Your password is saved successfully", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alertAction) -> Void in
                self.performSegue(withIdentifier: "toAuthenticationVCSegue", sender: self)
            })
            alertController.addAction(okAction)
            
            present(alertController, animated: true, completion: nil)
        }
        else { print("Error when saving") }
    }

    @IBAction func viewTapped(_ sender: AnyObject) {
        passwordTextField.resignFirstResponder()
    }

    // MARK: - UITextField Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.text == "" { return false }
        
        let isSaved: Bool = KeychainWrapper.setString(passwordTextField.text!, forKey: kPasswordKey)
        if isSaved {
            print("Saved Successfully")
            
            // show alert
            let alertController = UIAlertController(title: "Password Saved", message: "Your password is saved successfully", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alertAction) -> Void in
                self.performSegue(withIdentifier: "toAuthenticationVCSegue", sender: self)
            })
            alertController.addAction(okAction)
            
            present(alertController, animated: true, completion: nil)
        }
        else { print("Error when saving") }
        return false
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toAuthenticationVCSegue" {
//            let authenticationVC = segue.destination as! AuthenticationViewController
//            authenticationVC.managedObjectContext = self.managedObjectContext
        }
    }

}
