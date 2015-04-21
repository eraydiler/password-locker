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
    
    var managedObjectContext: NSManagedObjectContext?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        var segueID = String("")
        (checkPassword()) ? (segueID = "toAuthenticationVCSegue") : (segueID = "toCreatePasswordVCSegue")
        self.performSegueWithIdentifier(segueID, sender: nil)
    }
    
    // Helper Methods
    func checkPassword() -> Bool {
        return (KeychainWrapper.stringForKey(kPasswordKey) != nil)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toAuthenticationVCSegue" {
            var authenticationVC = segue.destinationViewController as! AuthenticationViewController
            authenticationVC.managedObjectContext = self.managedObjectContext
        } else {
            var createPassVC = segue.destinationViewController as! CreatePasswordViewController
            createPassVC.managedObjectContext = self.managedObjectContext
        }
    }

}
