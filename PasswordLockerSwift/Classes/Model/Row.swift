//
//  Row.swift
//  PasswordLockerSwift
//
//  Created by Eray on 09/04/15.
//  Copyright (c) 2015 Eray. All rights reserved.
//

import Foundation
import CoreData

class Row: NSManagedObject {

    @NSManaged var id: NSNumber
    @NSManaged var key: String
    @NSManaged var section: String
    @NSManaged var value: String
    @NSManaged var types: NSSet
    @NSManaged var savedObject: SavedObject

}