//
//  SavedObject.swift
//  PasswordLockerSwift
//
//  Created by Eray on 09/04/15.
//  Copyright (c) 2015 Eray. All rights reserved.
//

import Foundation
import CoreData

class SavedObject: NSManagedObject {

    @NSManaged var data: /*AnyObject*/ Array<Dictionary<String, String>>
    @NSManaged var date: NSDate
    @NSManaged var name: String
    @NSManaged var category: Category
    @NSManaged var type: Type
    @NSManaged var rows: NSSet

}
