//
//  PasswordUpdateViewController.swift
//  PasswordLockerSwift
//
//  Created by Eray on 16/12/2017.
//  Copyright © 2017 Eray. All rights reserved.
//

import UIKit

class PasswordUpdateViewController: PasswordCreationViewController {
    override func performSuccessAction() {
        view.endEditing(true)
        
        self.dismiss(animated: true)
    }
    
    override func displaySuccessAlert() {
        let alertController = UIAlertController(
            title: "Updated!",
            message: "Your password is updated successfully",
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
    
    @IBAction func didTap(closeButton: UIButton) {
        view.endEditing(true)
        
        self.dismiss(animated: true)
    }
}
