//
//  SplashViewController.swift
//  PasswordLockerSwift
//
//  Created by Eray on 21/04/15.
//  Copyright (c) 2015 Eray. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    private let TAG = "SplashViewController"

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        var segueID = ""
        (checkPassword()) ? (segueID = "toAuthenticationVCSegue") : (segueID = "toCreatePasswordVCSegue")
        self.performSegue(withIdentifier: segueID, sender: nil)
    }
    
    // Helper Methods

    func checkPassword() -> Bool {
        return (KeychainService.value(forKey: KeychainService.appPasswordKey) != nil)
    }
}
