//
//  SettingsViewController.swift
//  PasswordLockerSwift
//
//  Created by Eray on 30/04/16.
//  Copyright © 2016 Eray. All rights reserved.
//

import UIKit

private enum SectionType {
    case PasswordChange
    case BackupRestore
    case Share
    case Logout
}

private enum Item {
    case PasswordChange
    case BackupRestore
    case Share
    case Logout
}

private struct Section {
    var type: SectionType
    var items: [Item]
}

private var sections =  [
    Section(type: .PasswordChange, items: [.PasswordChange]),
    Section(type: .BackupRestore, items: [.BackupRestore]),
    Section(type: .Share, items: [.Share]),
    Section(type: .Logout, items: [.Logout]),
]

class SettingsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(tableView: UITableView,
                            didSelectRowAtIndexPath indexPath: NSIndexPath) {

        print("Selected \(indexPath.section) \(indexPath.row)")

        switch sections[indexPath.section].items[indexPath.row] {
        case .PasswordChange:
            break;
        case .BackupRestore:
            break;
        case .Share:
            break;
        case .Logout: // Logout
            if let tabBarController = self.tabBarController {
                tabBarController.dismissViewControllerAnimated(true, completion: nil)
            }

            break;
        }
    }    
}
