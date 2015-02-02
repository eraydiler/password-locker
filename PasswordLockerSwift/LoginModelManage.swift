//
//  LoginModelCreate.swift
//  PasswordLockerSwift
//
//  Created by Eray on 01/02/15.
//  Copyright (c) 2015 Eray. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension LoginModel {
    
    class func loginMoldelWithName(name: NSString, atIndexPath indexPath: NSIndexPath) -> LoginModel {
        //        var login = NSEntityDescription.insertNewObjectForEntityForName("LoginModel", inManagedObjectContext: managedObjectContext!) as LoginModel
        let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext
        
        let entity = NSEntityDescription .entityForName("LoginModel", inManagedObjectContext: managedObjectContext!)
        var login = LoginModel(entity: entity!, insertIntoManagedObjectContext: managedObjectContext)
        
        login.name = name
        login.rowIndex = indexPath.row as NSNumber
        
        var error: NSError?
        if !managedObjectContext!.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
        
        return login as LoginModel
    }
    
    class func deleteLoginModel(loginModel: LoginModel) {
        let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext

        managedObjectContext?.deleteObject(loginModel)
        
        var error : NSError?
        if !managedObjectContext!.save(&error) {
            println(" \(error?.localizedDescription)")
        }
    }
    
    class func deleteRelatedFields(loginModel: LoginModel) {
        let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext

        let fetchRequest = NSFetchRequest(entityName: "LoginModelField")
        fetchRequest.predicate = NSPredicate(format: "loginModel.name == %@", loginModel.name)
        
        var error: NSError?
        let loginModelFields = managedObjectContext?.executeFetchRequest(fetchRequest, error: &error)
        
        if error != nil { println(" \(error?.localizedDescription)") }
        
        for field in loginModelFields! {
            managedObjectContext?.deleteObject(field as LoginModel)
        }
        
        error = nil
        if(managedObjectContext!.save(&error) ) {
            println(error?.localizedDescription)
        }
    }
}