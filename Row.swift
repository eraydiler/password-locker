//
//  Row.swift
//  PasswordLockerSwift
//
//  Created by Eray on 08/04/15.
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

}

extension Row {
    func addTypeToRow(type: Type) {
        var types = self.mutableSetValueForKey("types")
        types.addObject(type)
    }
    
    func getNumberOfTypes() -> Int {
        return self.types.count
    }
    
    func getTypesAsArray() -> [Type] {
        var types: [Type]
        types = self.types.allObjects as [Type]
        
        return types
    }
}