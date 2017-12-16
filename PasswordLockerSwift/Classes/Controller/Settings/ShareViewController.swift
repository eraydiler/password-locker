//
//  ShareViewController.swift
//  PasswordLockerSwift
//
//  Created by Eray on 01/05/15.
//  Copyright (c) 2015 Eray. All rights reserved.
//

import UIKit
import Social

class ShareViewController: UIViewController {

    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Actions
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        if sender.titleLabel?.text == "Facebook" {

            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook){
                let facebookSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
                
                facebookSheet.setInitialText(
                    "Hey, \n\n I'm using this awesome app to keep my passwords in secure.\n\nVisit http://eraydiler.com for more.")
                
                self.present(facebookSheet, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Accounts",
                                              message: "Please login to a Facebook account to share.",
                                              preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            if SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) {
                let twitterSheet:SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
                
                twitterSheet.setInitialText("Hey, \n\n I'm using this awesome app to keep my passwords in secure.\n\nVisit http://eraydiler.com for more.")
                self.present(twitterSheet, animated: true, completion: nil)
            } else {
                let alert = UIAlertController(title: "Accounts",
                                              message: "Please login to a Twitter account to share.",
                                              preferredStyle: UIAlertControllerStyle.alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func exitTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
