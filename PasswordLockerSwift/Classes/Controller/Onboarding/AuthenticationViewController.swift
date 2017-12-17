//
//  AuthenticationViewController.swift
//  PasswordLockerSwift
//
//  Created by Eray on 19/01/15.
//  Copyright (c) 2015 Eray. All rights reserved.
//

import UIKit
import CoreData
import LocalAuthentication

class AuthenticationViewController: UIViewController, TouchIDAuthenticable {
    let TAG = "AuthenticationViewController"
    
    @IBOutlet weak var passwordTextField: UITextField!

    var shouldShowTouchIDAuthentication: Bool {
        return isTouchIdAvailable && Preferences.isTouchIdEnabled
    }
    
    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        passwordTextField.delegate = self
        passwordTextField.setValue(UIColor.gray, forKeyPath: "_placeholderLabel.textColor")
        passwordTextField.tintColor = UIColor.white
        
        registerForNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        attemptToLoginWithTouchID()
    }
    
    // MARK: - Deinit
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Notifications
    
    private func registerForNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didReceive(applicationWillEnterForeground:)),
            name: .UIApplicationWillEnterForeground,
            object: nil)
    }
    
    func didReceive(applicationWillEnterForeground notification: Notification) {
        attemptToLoginWithTouchID()
    }
    
    // MARK: - Touch id
    
    private func attemptToLoginWithTouchID() {
        guard shouldShowTouchIDAuthentication else {
            return
        }
        
        authenticateUser(onCompletion: { (error) in
            guard error == nil else {
                return
            }
            
            self.performSegue(withIdentifier: "AuthenticationToTabBarController", sender: nil)
        })
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)        
        let defaultAction = UIAlertAction(title: "OK", style: .default)
        
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }

    // MARK: - IBActions

    @IBAction func deletePassLockButtonPressed(_ sender: AnyObject) {
        let isRemoved = KeychainService.removeValue(forKey: KeychainService.appPasswordKey)

        guard isRemoved else {
            print("Error when removing password")
            
            return
        }
        
        print("Password removed successfully")
        
        showAlert(title: "Password Removed", message: "Your password is removed successfully")
    }

    @IBAction func viewTapped(_ sender: AnyObject) {
        passwordTextField.resignFirstResponder()
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AuthenticationToTabBarController" {
            passwordTextField.text = nil
        }
    }
    
    // Helper Methods
    
    func checkPassword() -> Bool {
        return (KeychainService.value(forKey: KeychainService.appPasswordKey) != nil)
    }
}

// MARK: - UITextField Delegate

extension AuthenticationViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text as NSString? else {
            return true
        }
        
        let replacedText = text.replacingCharacters(in: range, with: string)
        
        guard
            replacedText.count > 0,
            let password = KeychainService.value(forKey: KeychainService.appPasswordKey) else {
                
                return true
        }
        
        if replacedText == password {
            print("Login Successful")
            
            self.performSegue(withIdentifier: "AuthenticationToTabBarController", sender: nil)
        }
        
        return true
    }
}

