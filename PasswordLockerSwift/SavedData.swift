//
//  SavedData.swift
//  PasswordLockerSwift
//
//  Created by Eray on 02/04/15.
//  Copyright (c) 2015 Eray. All rights reserved.
//

import Foundation
import CoreData

class SavedData: NSManagedObject {

    @NSManaged var data: /*AnyObject*/ Array<Dictionary<String, String>>
    @NSManaged var date: NSDate
    @NSManaged var type: Type

}
