//
//  Mail.swift
//  PasswordLockerSwift
//
//  Created by Eray on 09/05/16.
//  Copyright © 2016 Eray. All rights reserved.
//

import Foundation

class Email {
    var name: String {
        get {
            return self.name
        }
        set {
            if self.name.isEmpty {
                self.name = "Email"
            }

            self.name = newValue
        }
    }

    let username: String?   = nil
    let password: String?   = nil
    let smtpServer: String? = nil
    let server: String?     = nil
    let serverType: String? = nil
    let webMail: String?    = nil
    let note: String        = "No note"
}