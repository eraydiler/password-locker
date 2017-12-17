//
//  TouchIDAuthentication.swift
//  PasswordLockerSwift
//
//  Created by Eray on 17/12/2017.
//  Copyright © 2017 Eray. All rights reserved.
//

import LocalAuthentication

protocol TouchIDAuthenticable {
    func authenticateUser(onCompletion completion: @escaping (_ error: Error?) -> Void)
}

extension TouchIDAuthenticable {
    var isTouchIdAvailable: Bool {
        let context = LAContext()
        
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
    }
    
    func authenticateUser(onCompletion completion: @escaping (_ error: Error?) -> Void) {
        if !isTouchIdAvailable {
            return
        }
        
        let context = LAContext()
        
        context.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: "Logging in with Touch ID") { (success, error) in
                if success {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(error)
                    }
                }
        }
    }
}
