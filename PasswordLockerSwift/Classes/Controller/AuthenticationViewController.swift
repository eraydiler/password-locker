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

    let kPasswordKey = "PassLock"

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        passwordTextField.delegate = self
        passwordTextField.setValue(UIColor.gray, forKeyPath: "_placeholderLabel.textColor")
        passwordTextField.tintColor = UIColor.white
    }

    // MARK: - IBActions

    @IBAction func deletePassLockButtonPressed(_ sender: AnyObject) {
        let isRemoved = KeychainService.removeValue(forKey: kPasswordKey)

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

    @IBAction func viewTapped(_ sender: AnyObject) {
        passwordTextField.resignFirstResponder()
    }

    // MARK: - UITextField Delegate

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text as NSString? else {
            return true
        }

        let replacedText = text.replacingCharacters(in: range, with: string)

        guard
            replacedText.characters.count > 0,
            let password = KeychainService.value(forKey: kPasswordKey) else {

                return true
        }

        if replacedText == password {
            print("Login Successful")

            self.performSegue(withIdentifier: "AuthenticationToTabBarController", sender: nil)
        }

        return true
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AuthenticationToTabBarController" {
            passwordTextField.text = nil
        }
    }
    
    // Helper Methods
    func checkPassword() -> Bool {
        return (KeychainService.value(forKey: kPasswordKey) != nil)
    }
}

