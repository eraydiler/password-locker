//
//  Type.swift
//  PasswordLockerSwift
//
//  Created by Eray on 09/04/15.
//  Copyright (c) 2015 Eray. All rights reserved.
//

import Foundation
import CoreData

class Type: NSManagedObject {

    @NSManaged var imageName: String
    @NSManaged var name: String
    @NSManaged var category: Category
    @NSManaged var rows: NSSet
    @NSManaged var savedObjects: NSSet

}
