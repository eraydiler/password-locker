//
//  InsertData.swift
//  PasswordLockerSwift
//
//  Created by Eray on 17/03/15.
//  Copyright (c) 2015 Eray. All rights reserved.
//

import UIKit
import CoreData

class InsertData: NSObject {
    
    var managedObjectContext: NSManagedObjectContext?
    
    class func setupInitialData(managedObjectContext: NSManagedObjectContext) {
        let moc: NSManagedObjectContext = managedObjectContext
        
        // Account Category
        var category1: Category = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: moc) as Category
        category1.name = "Account"
        category1.imageName = "user"
        
        var category2: Category = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: moc) as Category
        category2.name = "Web"
        category2.imageName = "globe"
        
        var category3: Category = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: moc) as Category
        category3.name = "Note"
        category3.imageName = "note"
        
        var category4: Category = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: moc) as Category
        category4.name = "Email"
        category4.imageName = "email"
        
        var category5: Category = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: moc) as Category
        category5.name = "Wallet"
        category5.imageName = "wallet"
        
        // Account Types
        var type1: Type = NSEntityDescription.insertNewObjectForEntityForName("Type", inManagedObjectContext: moc) as Type
        type1.name = "Generic Account"
        type1.imageName = "genericAccount"
        
        var type2: Type = NSEntityDescription.insertNewObjectForEntityForName("Type", inManagedObjectContext: moc) as Type
        type2.name = "Instant Messenger"
        type2.imageName = "instantMessenger"
        
        var type3: Type = NSEntityDescription.insertNewObjectForEntityForName("Type", inManagedObjectContext: moc) as Type
        type3.name = "Software Licence"
        type3.imageName = "softwareLicence"
        
        var type4: Type = NSEntityDescription.insertNewObjectForEntityForName("Type", inManagedObjectContext: moc) as Type
        type4.name = "Database"
        type4.imageName = "database"
        
        var type5: Type = NSEntityDescription.insertNewObjectForEntityForName("Type", inManagedObjectContext: moc) as Type
        type5.name = "Ftp Server"
        type5.imageName = "ftpServer"
        
        var type6: Type = NSEntityDescription.insertNewObjectForEntityForName("Type", inManagedObjectContext: moc) as Type
        type6.name = "Wireless Router"
        type6.imageName = "wirelessRouter"
        
        var type7: Type = NSEntityDescription.insertNewObjectForEntityForName("Type", inManagedObjectContext: moc) as Type
        type7.name = "Server"
        type7.imageName = "server"
        
        // Rows - Generic Account
        var rows1: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rows1.key = "@img(genericAccount)"
        rows1.value = "Generic Account"
        rows1.section = 0
        
        var rows2: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rows2.key = "Username"
        rows2.value = ""
        rows2.section = 0
        
        var rows3: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rows3.key = "Password"
        rows3.value = ""
        rows3.section = 0
        
        var rows4: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rows4.key = "Notes"
        rows4.value = ""
        rows4.section = 1
        
        // save `NSManagedObjectContext`
        var error: NSError?
        if !moc.save(&error) {
            println("finish error: \(error!.localizedDescription)")
            abort()
        }
    }
}
