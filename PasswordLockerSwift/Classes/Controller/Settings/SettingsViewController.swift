//
//  SettingsViewController.swift
//  PasswordLockerSwift
//
//  Created by Eray on 30/04/16.
//  Copyright © 2016 Eray. All rights reserved.
//

import UIKit

private enum SectionType {
    case passwordChange
    case backupRestore
    case share
    case logout
}

private enum Item {
    case passwordChange
    case backupRestore
    case share
    case logout
}

private struct Section {
    var type: SectionType
    var items: [Item]
}

private var sections =  [
    Section(type: .passwordChange, items: [.passwordChange]),
    Section(type: .backupRestore, items: [.backupRestore]),
    Section(type: .share, items: [.share]),
    Section(type: .logout, items: [.logout]),
]

class SettingsViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {

        print("Selected \(indexPath.section) \(indexPath.row)")

        switch sections[indexPath.section].items[indexPath.row] {
        case .passwordChange:
            break;
        case .backupRestore:
            break;
        case .share:
            break;
        case .logout: // Logout
            if let tabBarController = self.tabBarController {
                tabBarController.dismiss(animated: true, completion: nil)
            }

            break;
        }
    }    
}
