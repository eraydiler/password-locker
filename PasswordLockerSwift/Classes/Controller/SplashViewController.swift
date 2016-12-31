//
//  SplashViewController.swift
//  PasswordLockerSwift
//
//  Created by Eray on 21/04/15.
//  Copyright (c) 2015 Eray. All rights reserved.
//

import UIKit
import CoreData

class SplashViewController: UIViewController {
    let kPasswordKey="PassLock"
    let TAG = "SplashViewController"

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print(TAG + " receive memory warning")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        var segueID = ""
        (checkPassword()) ? (segueID = "toAuthenticationVCSegue") : (segueID = "toCreatePasswordVCSegue")
        self.performSegue(withIdentifier: segueID, sender: nil)
    }
    
    // Helper Methods
    func checkPassword() -> Bool {
        return (KeychainWrapper.stringForKey(kPasswordKey) != nil)
    }
}
