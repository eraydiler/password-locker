//
//  Keychain.swift
//  PasswordLockerSwift
//
//  Created by Eray on 07/08/2017.
//  Copyright © 2017 Eray. All rights reserved.
//

import UIKit
import KeychainAccess

protocol LocalStorageService {
    static func set(value: String, forKey key: String) -> Bool
    static func value(forKey key: String) -> String?
    static func removeValue(forKey key: String) -> Bool
}

class KeychainService: LocalStorageService {
    static func set(value: String, forKey key: String) -> Bool {
        let keychain = Keychain()

        do {
            try keychain.set(value, key: key)
        } catch {
            return false
        }

        return true
    }

    static func value(forKey key: String) -> String? {
        let keychain = Keychain()

        return keychain[key]
    }

    static func removeValue(forKey key: String) -> Bool {
        let keychain = Keychain()

        do {
            try keychain.remove(key)

        } catch {
            return false
        }

        return true
    }
}
