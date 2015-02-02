//
//  LoginModelFieldManage.swift
//  PasswordLockerSwift
//
//  Created by Eray on 01/02/15.
//  Copyright (c) 2015 Eray. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension LoginModelField {
    
    class func loginFieldWithName(loginModel: LoginModel, keyAndValue: (String, String), atIndexPath indexPath: NSIndexPath) -> LoginModelField {
        let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext

        var field: LoginModelField = NSEntityDescription .insertNewObjectForEntityForName("LoginModelField", inManagedObjectContext: managedObjectContext!) as LoginModelField
        
        field.key = keyAndValue.0
        field.value = keyAndValue.1
        field.rowIndex = indexPath.row
        field.loginModel = loginModel
//        self .save()
       
        var error: NSError? = nil
        if !managedObjectContext!.save(&error) {
            println(" Could not save \(error), \(error?.userInfo)")
        }
        return field
    }
    
     class func deleteLodinModelField(field: LoginModelField) {
        let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext

        managedObjectContext? .deleteObject(field)
//        self .save()
        var error: NSError? = nil
        if !managedObjectContext!.save(&error) {
            println(" Could not save \(error), \(error?.userInfo)")
        }
    }
    
    func save() {
        let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext

        var error: NSError? = nil
        if !managedObjectContext!.save(&error) {
            println(" Could not save \(error), \(error?.userInfo)")
        }
    }
}