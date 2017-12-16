//
//  SettingsViewController.swift
//  PasswordLockerSwift
//
//  Created by Eray on 30/04/16.
//  Copyright © 2016 Eray. All rights reserved.
//

import UIKit

// Nice approach for nested table view structures
//private enum SectionType {
//    case passwordChange
//    case backupRestore
//    case share
//    case logout
//}
//
//private enum Item {
//    case passwordChange
//    case backupRestore
//    case share
//    case logout
//}
//
//private struct Section {
//    var type: SectionType
//    var items: [Item]
//}
//
//private var sections =  [
//    Section(type: .passwordChange, items: [.passwordChange]),
//    Section(type: .backupRestore, items: [.backupRestore]),
//    Section(type: .share, items: [.share]),
//    Section(type: .logout, items: [.logout]),
//]


class SettingsViewController: UITableViewController {
    fileprivate enum SectionType {
        case password
        case backupRestore
        case share
        case logout
    }
    
    fileprivate var sections: [SectionType] = [
        .password,
        .backupRestore,
        .share,
        .logout
    ]

    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Private methods
    
    fileprivate func logout() {
        if let tabBarController = self.tabBarController {
            tabBarController.dismiss(animated: true, completion: nil)
        }
    }
}

// MARK: - Table view delegate

extension SettingsViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        
        switch sections[indexPath.section] {
        case .logout:
            logout()
            
        default:
            break
        }
    }
}
