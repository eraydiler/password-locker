//
//  CreatePasswordViewController.swift
//  PasswordLockerSwift
//
//  Created by Eray on 21/04/15.
//  Copyright (c) 2015 Eray. All rights reserved.
//

import UIKit
import CoreData

class CreatePasswordViewController: UIViewController {    
    @IBOutlet weak var passwordTextField: UITextField!

    // MARK: - Computed properties
    
    fileprivate var isFieldEmpty: Bool {
        guard let text = passwordTextField.text else {
            return false
        }
        
        return text.isEmpty
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        configureView()
    }

    func configureView() {
        self.passwordTextField.setValue(UIColor.gray, forKeyPath: "_placeholderLabel.textColor")
        self.passwordTextField.tintColor = UIColor.gray
        self.passwordTextField.delegate = self
    }
    
    // MARK: - IBActions

    @IBAction func checkButtonPressed(_ sender: AnyObject) {
        guard let retrieveString = KeychainService.value(forKey: KeychainService.appPasswordKey) else {
            return
        }

        print("\(retrieveString)")
    }
    
    @IBAction func addPassLockButtonPressed(_ sender: AnyObject) {
        attemptToSavePassword()
    }

    @IBAction func viewTapped(_ sender: AnyObject) {
        passwordTextField.resignFirstResponder()
    }
    
    // MARK: - Private methods
    
    @discardableResult
    fileprivate func attemptToSavePassword() -> Bool {
        guard !isFieldEmpty else {
            print(">>> TEXT FIELD IS EMPTY")
            
            return false
        }
        
        let isSaved: Bool = KeychainService.set(value: passwordTextField.text!, forKey: KeychainService.appPasswordKey)
        
        guard isSaved else {
            print(">>> AN ERROR OCCURED WHILE SAVING PASSWORD")
            
            return false
        }
        
        print(">>> PASSWORD SAVED SUCCESSFULLY")
        
        displaySuccessAlert()
        
        return true
    }
    
    fileprivate func displaySuccessAlert() {
        let alertController = UIAlertController(title: "Password Saved",
                                                message: "Your password is saved successfully",
                                                preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: { (alertAction) -> Void in
            self.performSegue(withIdentifier: "toAuthenticationVCSegue", sender: self)
        })
        
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

extension CreatePasswordViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return attemptToSavePassword()
    }
}
