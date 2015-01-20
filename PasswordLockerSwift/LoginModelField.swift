//
//  LoginModelField.swift
//  PasswordLockerSwift
//
//  Created by Eray on 20/01/15.
//  Copyright (c) 2015 Eray. All rights reserved.
//

import Foundation
import CoreData

class LoginModelField: NSManagedObject {

    @NSManaged var key: String
    @NSManaged var rowIndex: NSNumber
    @NSManaged var value: String
    @NSManaged var loginModel: LoginModel

}
