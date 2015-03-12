//
//  Categories.swift
//  PasswordLockerSwift
//
//  Created by Eray on 11/03/15.
//  Copyright (c) 2015 Eray. All rights reserved.
//

import Foundation
import CoreData

class Categories: NSManagedObject {

    @NSManaged var name: String
    @NSManaged var types: NSSet

}
