//
//  PasswordCreationViewController.swift
//  PasswordLockerSwift
//
//  Created by Eray on 21/04/15.
//  Copyright (c) 2015 Eray. All rights reserved.
//

import UIKit
import CoreData

class PasswordCreationViewController: UIViewController {    
    @IBOutlet weak var passwordTextField: UITextField!

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        configureView()
    }
    
    // MARK: - Configuration

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
        guard let text = passwordTextField.text, !text.isEmpty else {
            print(">>> TEXT FIELD IS EMPTY")
            
            return false
        }
        
        let isSaved: Bool = KeychainService.set(value: text, forKey: KeychainService.appPasswordKey)
        
        guard isSaved else {
            print(">>> AN ERROR OCCURED WHILE SAVING PASSWORD")
            
            return false
        }
        
        print(">>> PASSWORD SAVED SUCCESSFULLY")
        
        displaySuccessAlert()
        
        return true
    }
    
    func displaySuccessAlert() {
        fatalError("Must be implemented by subclasses")
    }
    
    // MARK: - Subclass methods
    
    func performSuccessAction() {
        fatalError("Must be implemented by subclasses")
    }
}

// MARK: - Text field delegate

extension PasswordCreationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return attemptToSavePassword()
    }
}
