//
//  OnboardingPasswordCreationViewController.swift
//  PasswordLockerSwift
//
//  Created by Eray on 16/12/2017.
//  Copyright © 2017 Eray. All rights reserved.
//

import UIKit

class OnboardingPasswordCreationViewController: PasswordCreationViewController {    
    override func performSuccessAction() {
        self.performSegue(withIdentifier: "toAuthenticationVCSegue", sender: self)
    }
    
    override func displaySuccessAlert() {
        let alertController = UIAlertController(
            title: "Saved!",
            message: "Your password is saved successfully",
            preferredStyle: .alert)
        
        let okAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: { (alertAction) -> Void in
                
                self.performSuccessAction()
        })
        
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
