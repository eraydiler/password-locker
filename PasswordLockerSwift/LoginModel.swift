//
//  LoginModel.swift
//  PasswordLockerSwift
//
//  Created by Eray on 22/01/15.
//  Copyright (c) 2015 Eray. All rights reserved.
//

import Foundation
import CoreData

class LoginModel: NSManagedObject {

    @NSManaged var date: NSDate
    @NSManaged var name: String
    @NSManaged var rowIndex: NSNumber
    @NSManaged var fields: NSSet
    
    override func awakeFromInsert() {
        super.awakeFromInsert()
        self.date = NSDate()
    }
    
    override func validateForInsert(error: NSErrorPointer) -> Bool {
        let res = super.validateForInsert(error)
        println(res)
        return res
    }
}
