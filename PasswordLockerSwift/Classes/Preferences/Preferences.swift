//
//  Preferences.swift
//  PasswordLockerSwift
//
//  Created by Eray on 16/12/2017.
//  Copyright © 2017 Eray. All rights reserved.
//

import UIKit

class Preferences {
    private enum Keys: String {
        case touchId = "com.passwordlocker.preferences.keys.touchId"
    }
    
    static var isTouchIdEnabled: Bool {
        get {
            return bool(forKey: Keys.touchId.rawValue)
        }
        set {
            sync(object: newValue, forKey: Keys.touchId.rawValue)
        }
    }
    
    // MARK: Private API
    
    private static var defaults: UserDefaults {
        return UserDefaults.standard
    }
    
    private static func bool(forKey key: String) -> Bool {
        return defaults.bool(forKey: key)
    }
    
    private static func sync(object: Any, forKey key: String) {
        defaults.set(object, forKey: key)
        defaults.synchronize()
    }
}
