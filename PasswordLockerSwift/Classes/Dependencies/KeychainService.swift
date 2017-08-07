//
//  Keychain.swift
//  PasswordLockerSwift
//
//  Created by Eray on 07/08/2017.
//  Copyright © 2017 Eray. All rights reserved.
//

import UIKit

protocol LocalStorageService {
    static func set(value: String, forKey key: String) -> Bool
    static func value(forKey key: String) -> String?
    static func removeValue(forKey key: String) -> Bool
}

class KeychainService: LocalStorageService {
    class func set(value: String, forKey key: String) -> Bool {
        return KeychainWrapper.setString(value, forKey: key)
    }

    class func value(forKey key: String) -> String? {
        return KeychainWrapper.stringForKey(key)
    }

    class func removeValue(forKey key: String) -> Bool {
        return KeychainWrapper.removeObjectForKey(key)
    }
}
