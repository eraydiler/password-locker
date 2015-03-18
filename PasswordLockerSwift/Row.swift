//
//  Rows.swift
//  PasswordLockerSwift
//
//  Created by Eray on 17/03/15.
//  Copyright (c) 2015 Eray. All rights reserved.
//

import Foundation
import CoreData

class Row: NSManagedObject {

    @NSManaged var key: String
    @NSManaged var value: String
    @NSManaged var section: String
    @NSManaged var types: NSSet

}
