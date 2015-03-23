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
        
        
        // MARK: - Categories
        
        var categoryAccount: Category = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: moc) as Category
        categoryAccount.name = "Account"
        categoryAccount.imageName = "user"
        
        var categoryWeb: Category = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: moc) as Category
        categoryWeb.name = "Web"
        categoryWeb.imageName = "globe"
        
        var categoryNote: Category = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: moc) as Category
        categoryNote.name = "Note"
        categoryNote.imageName = "note"
        
        var categoryEmail: Category = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: moc) as Category
        categoryEmail.name = "Email"
        categoryEmail.imageName = "email"
        
        var categoryWallet: Category = NSEntityDescription.insertNewObjectForEntityForName("Category", inManagedObjectContext: moc) as Category
        categoryWallet.name = "Wallet"
        categoryWallet.imageName = "wallet"
        
        
        // MARK: - Account Types
        
        var typeGenericAcc: Type = NSEntityDescription.insertNewObjectForEntityForName("Type", inManagedObjectContext: moc) as Type
        typeGenericAcc.name = "Generic Account"
        typeGenericAcc.imageName = "genericAccount"
        typeGenericAcc.category = categoryAccount
        
        var typeInstnMssngr: Type = NSEntityDescription.insertNewObjectForEntityForName("Type", inManagedObjectContext: moc) as Type
        typeInstnMssngr.name = "Instant Messenger"
        typeInstnMssngr.imageName = "instantMessenger"
        typeInstnMssngr.category = categoryAccount
        
        var typeSoftwrLcnc: Type = NSEntityDescription.insertNewObjectForEntityForName("Type", inManagedObjectContext: moc) as Type
        typeSoftwrLcnc.name = "Software Licence"
        typeSoftwrLcnc.imageName = "softwareLicence"
        typeSoftwrLcnc.category = categoryAccount
        
        var typeDatabase: Type = NSEntityDescription.insertNewObjectForEntityForName("Type", inManagedObjectContext: moc) as Type
        typeDatabase.name = "Database"
        typeDatabase.imageName = "database"
        typeDatabase.category = categoryAccount
        
        var typeFtpServer: Type = NSEntityDescription.insertNewObjectForEntityForName("Type", inManagedObjectContext: moc) as Type
        typeFtpServer.name = "Ftp Server"
        typeFtpServer.imageName = "ftpServer"
        typeFtpServer.category = categoryAccount
        
        var typeWirelessRtr: Type = NSEntityDescription.insertNewObjectForEntityForName("Type", inManagedObjectContext: moc) as Type
        typeWirelessRtr.name = "Wireless Router"
        typeWirelessRtr.imageName = "wirelessRouter"
        typeWirelessRtr.category = categoryAccount
        
        var typeServer: Type = NSEntityDescription.insertNewObjectForEntityForName("Type", inManagedObjectContext: moc) as Type
        typeServer.name = "Server"
        typeServer.imageName = "server"
        typeServer.category = categoryAccount
        
        
        // MARK: - Web Types
        
        var typeRegular: Type = NSEntityDescription.insertNewObjectForEntityForName("Type", inManagedObjectContext: moc) as Type
        typeRegular.name = "Regular"
        typeRegular.imageName = "regularWeb"
        typeRegular.category = categoryWeb
        
        var typeFacebook: Type = NSEntityDescription.insertNewObjectForEntityForName("Type", inManagedObjectContext: moc) as Type
        typeFacebook.name = "Facebook"
        typeFacebook.imageName = "facebook"
        typeFacebook.category = categoryWeb
        
        var typeGoogle: Type = NSEntityDescription.insertNewObjectForEntityForName("Type", inManagedObjectContext: moc) as Type
        typeGoogle.name = "Google"
        typeGoogle.imageName = "google"
        typeGoogle.category = categoryWeb
        
        var typeTwitter: Type = NSEntityDescription.insertNewObjectForEntityForName("Type", inManagedObjectContext: moc) as Type
        typeTwitter.name = "Twitter"
        typeTwitter.imageName = "twitter"
        typeTwitter.category = categoryWeb
        
        var typeInstagram: Type = NSEntityDescription.insertNewObjectForEntityForName("Type", inManagedObjectContext: moc) as Type
        typeInstagram.name = "Instagram"
        typeInstagram.imageName = "instagram"
        typeInstagram.category = categoryWeb
        
        var typeFlickr: Type = NSEntityDescription.insertNewObjectForEntityForName("Type", inManagedObjectContext: moc) as Type
        typeFlickr.name = "Flickr"
        typeFlickr.imageName = "flickr"
        typeFlickr.category = categoryWeb
        
        var typeYoutube: Type = NSEntityDescription.insertNewObjectForEntityForName("Type", inManagedObjectContext: moc) as Type
        typeYoutube.name = "Youtube"
        typeYoutube.imageName = "youtube"
        typeYoutube.category = categoryWeb
        
        var typeLinkedin: Type = NSEntityDescription.insertNewObjectForEntityForName("Type", inManagedObjectContext: moc) as Type
        typeLinkedin.name = "Linkedin"
        typeLinkedin.imageName = "linkedin"
        typeLinkedin.category = categoryWeb
        
        var typeYahoo: Type = NSEntityDescription.insertNewObjectForEntityForName("Type", inManagedObjectContext: moc) as Type
        typeYahoo.name = "Yahoo"
        typeYahoo.imageName = "yahoo"
        typeYahoo.category = categoryWeb
        
        var typePaypal: Type = NSEntityDescription.insertNewObjectForEntityForName("Type", inManagedObjectContext: moc) as Type
        typePaypal.name = "Paypal"
        typePaypal.imageName = "paypal"
        typePaypal.category = categoryWeb
        
        var typeAmazon: Type = NSEntityDescription.insertNewObjectForEntityForName("Type", inManagedObjectContext: moc) as Type
        typeAmazon.name = "Amazon"
        typeAmazon.imageName = "amazon"
        typeAmazon.category = categoryWeb
        
        var typeEbay: Type = NSEntityDescription.insertNewObjectForEntityForName("Type", inManagedObjectContext: moc) as Type
        typeEbay.name = "Ebay"
        typeEbay.imageName = "ebay"
        typeEbay.category = categoryWeb
        
        var typeWordpress: Type = NSEntityDescription.insertNewObjectForEntityForName("Type", inManagedObjectContext: moc) as Type
        typeWordpress.name = "Wordpress"
        typeWordpress.imageName = "wordpress"
        typeWordpress.category = categoryWeb
        
        
        // MARK: - Email Types
        
        var typeRegularMail: Type = NSEntityDescription.insertNewObjectForEntityForName("Type", inManagedObjectContext: moc) as Type
        typeRegularMail.name = "Regular Mail"
        typeRegularMail.imageName = "regularMail"
        typeRegularMail.category = categoryEmail
        
        var typeGmail: Type = NSEntityDescription.insertNewObjectForEntityForName("Type", inManagedObjectContext: moc) as Type
        typeGmail.name = "Gmail"
        typeGmail.imageName = "gmail"
        typeGmail.category = categoryEmail
        
        var typeHotmail: Type = NSEntityDescription.insertNewObjectForEntityForName("Type", inManagedObjectContext: moc) as Type
        typeHotmail.name = "Hotmail"
        typeHotmail.imageName = "hotmail"
        typeHotmail.category = categoryEmail
        
        var typeYahooMail: Type = NSEntityDescription.insertNewObjectForEntityForName("Type", inManagedObjectContext: moc) as Type
        typeYahooMail.name = "Yahoo"
        typeYahooMail.imageName = "yahoo"
        typeYahooMail.category = categoryEmail
        
        
        // MARK: - Wallet Types
        
        var typeBankAccount: Type = NSEntityDescription.insertNewObjectForEntityForName("Type", inManagedObjectContext: moc) as Type
        typeBankAccount.name = "Bank Account"
        typeBankAccount.imageName = "bankAccount"
        typeBankAccount.category = categoryWallet
        
        var typeCreditCard: Type = NSEntityDescription.insertNewObjectForEntityForName("Type", inManagedObjectContext: moc) as Type
        typeCreditCard.name = "Credit Card"
        typeCreditCard.imageName = "creditCard"
        typeCreditCard.category = categoryWallet
        
        var typeID: Type = NSEntityDescription.insertNewObjectForEntityForName("Type", inManagedObjectContext: moc) as Type
        typeID.name = "ID"
        typeID.imageName = "ID"
        typeID.category = categoryWallet
        
        var typeDriverLicence: Type = NSEntityDescription.insertNewObjectForEntityForName("Type", inManagedObjectContext: moc) as Type
        typeDriverLicence.name = "Driver Licence"
        typeDriverLicence.imageName = "driveLicence"
        typeDriverLicence.category = categoryWallet
        
        var typeMembership: Type = NSEntityDescription.insertNewObjectForEntityForName("Type", inManagedObjectContext: moc) as Type
        typeMembership.name = "Membership"
        typeMembership.imageName = "membership"
        typeMembership.category = categoryWallet
        
        var typePassport: Type = NSEntityDescription.insertNewObjectForEntityForName("Type", inManagedObjectContext: moc) as Type
        typePassport.name = "Passport"
        typePassport.imageName = "passport"
        typePassport.category = categoryWallet
        
        
        // MARK: - Rows
        
        // Generic Account header row
        var rowGenericAccTitle: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowGenericAccTitle.key = "genericAccount"
        rowGenericAccTitle.value = "Generic Account"
        rowGenericAccTitle.section = "0"
        rowGenericAccTitle.types = NSSet(array: [typeGenericAcc])
        
        // Instant Messenger header row
        var rowInstanMsngrTitle: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowInstanMsngrTitle.key = "instantMessenger"
        rowInstanMsngrTitle.value = "Instant Messenger"
        rowInstanMsngrTitle.section = "0"
        rowInstanMsngrTitle.types = NSSet(array: [typeInstnMssngr])
        
        // Software Licence header row
        var rowSoftwareLicenceTitle: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowSoftwareLicenceTitle.key = "softwareLicence"
        rowSoftwareLicenceTitle.value = "Software Licence"
        rowSoftwareLicenceTitle.section = "0"
        rowSoftwareLicenceTitle.types = NSSet(array: [typeSoftwrLcnc])
        
        // Database header row
        var rowDatabaseTitle: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowDatabaseTitle.key = "database"
        rowDatabaseTitle.value = "Database"
        rowDatabaseTitle.section = "0"
        rowDatabaseTitle.types = NSSet(array: [typeDatabase])
        
        // Ftp Server header row
        var rowFtpServerTitle: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowFtpServerTitle.key = "ftpServer"
        rowFtpServerTitle.value = "Ftp Server"
        rowFtpServerTitle.section = "0"
        rowFtpServerTitle.types = NSSet(array: [typeFtpServer])
        
        // Ftp Server header row
        var rowWirlessRouterTitle: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowWirlessRouterTitle.key = "wirelessRouter"
        rowWirlessRouterTitle.value = "Wireless Router"
        rowWirlessRouterTitle.section = "0"
        rowWirlessRouterTitle.types = NSSet(array: [typeWirelessRtr])
        
        // Server header row
        var rowServerTitle: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowServerTitle.key = "server"
        rowServerTitle.value = "Server"
        rowServerTitle.section = "0"
        rowServerTitle.types = NSSet(array: [typeServer])
        
        // end of titles
        
        var rowUsername: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowUsername.key = "Username"
        rowUsername.value = ""
        rowUsername.section = "1"
        rowUsername.types = NSSet(array: [typeGenericAcc, typeDatabase, typeFtpServer, typeServer])
        
        var rowPassword: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowPassword.key = "Password"
        rowPassword.value = ""
        rowPassword.section = "1"
        rowPassword.types = NSSet(array: [typeGenericAcc, typeInstnMssngr, typeDatabase, typeFtpServer, typeWirelessRtr, typeServer])
        
        var rowNote: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowNote.key = "Note"
        rowNote.value = "No Note"
        rowNote.section = "2"
        rowNote.types = NSSet(array: [typeGenericAcc, typeInstnMssngr, typeDatabase, typeFtpServer, typeSoftwrLcnc, typeWirelessRtr, typeServer])
        
        var rowID: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowID.key = "ID"
        rowID.value = ""
        rowID.section = "1"
        rowID.types = NSSet(array: [typeInstnMssngr])
        
        var rowKey: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowKey.key = "Key"
        rowKey.value = ""
        rowKey.section = "1"
        rowKey.types = NSSet(array: [typeSoftwrLcnc])
        
        var rowType: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowType.key = "Type"
        rowType.value = ""
        rowType.section = "1"
        rowType.types = NSSet(array: [typeDatabase])
        
        var rowServer: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowServer.key = "Server"
        rowServer.value = ""
        rowServer.section = "1"
        rowServer.types = NSSet(array: [typeDatabase, typeFtpServer])
        
        var rowPort: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowPort.key = "Port"
        rowPort.value = ""
        rowPort.section = "1"
        rowPort.types = NSSet(array: [typeDatabase])
        
        var rowDatabase: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowDatabase.key = "Database"
        rowDatabase.value = ""
        rowDatabase.section = "1"
        rowDatabase.types = NSSet(array: [typeDatabase])
        
        var rowSID: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowSID.key = "SID"
        rowSID.value = ""
        rowSID.section = "1"
        rowSID.types = NSSet(array: [typeDatabase])
        
        var rowAlias: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowAlias.key = "Alias"
        rowAlias.value = ""
        rowAlias.section = "1"
        rowAlias.types = NSSet(array: [typeDatabase])
        
        var rowOptions: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowOptions.key = "Options"
        rowOptions.value = ""
        rowOptions.section = "1"
        rowOptions.types = NSSet(array: [typeDatabase])
        
        var rowPath: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowPath.key = "Path"
        rowPath.value = ""
        rowPath.section = "1"
        rowPath.types = NSSet(array: [typeFtpServer])
        
        var rowProvider: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowProvider.key = "Provider"
        rowProvider.value = ""
        rowProvider.section = "1"
        rowProvider.types = NSSet(array: [typeFtpServer])
        
        var rowWebsite: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowWebsite.key = "Website"
        rowWebsite.value = ""
        rowWebsite.section = "1"
        rowWebsite.types = NSSet(array: [typeFtpServer])
        
        var rowPhone: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowPhone.key = "Phone"
        rowPhone.value = ""
        rowPhone.section = "1"
        rowPhone.types = NSSet(array: [typeFtpServer])
        
        var rowStation: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowStation.key = "Password"
        rowStation.value = ""
        rowStation.section = "1"
        rowStation.types = NSSet(array: [typeWirelessRtr])
        
        var rowIpAddress: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowIpAddress.key = "Ip Address"
        rowIpAddress.value = ""
        rowIpAddress.section = "1"
        rowIpAddress.types = NSSet(array: [typeWirelessRtr])
        
        var rowAirportID: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowAirportID.key = "Airport ID"
        rowAirportID.value = ""
        rowAirportID.section = "1"
        rowAirportID.types = NSSet(array: [typeWirelessRtr])
        
        var rowNetwork: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowNetwork.key = "Network"
        rowNetwork.value = ""
        rowNetwork.section = "1"
        rowNetwork.types = NSSet(array: [typeWirelessRtr])
        
        var rowSecurity: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowSecurity.key = "Security"
        rowSecurity.value = ""
        rowSecurity.section = "1"
        rowSecurity.types = NSSet(array: [typeWirelessRtr])
        
        var rowNetwrkPass: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowNetwrkPass.key = "Network Passwd."
        rowNetwrkPass.value = ""
        rowNetwrkPass.section = "1"
        rowNetwrkPass.types = NSSet(array: [typeWirelessRtr])
        
        var rowStoragePass: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowStoragePass.key = "Storate Passwd."
        rowStoragePass.value = ""
        rowStoragePass.section = "1"
        rowStoragePass.types = NSSet(array: [typeWirelessRtr])
        
        var rowUrl: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowUrl.key = "Url"
        rowUrl.value = ""
        rowUrl.section = "1"
        rowUrl.types = NSSet(array: [typeServer])
        
        var rowName: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowName.key = "Name"
        rowName.value = ""
        rowName.section = "1"
        rowName.types = NSSet(array: [typeServer])
        
        var rowAdmPUrl: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowAdmPUrl.key = "Admin Panel URL"
        rowAdmPUrl.value = ""
        rowAdmPUrl.section = "1"
        rowAdmPUrl.types = NSSet(array: [typeServer])
        
        var rowAdmPUsername: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowAdmPUsername.key = "Adm.P.Username"
        rowAdmPUsername.value = ""
        rowAdmPUsername.section = "1"
        rowAdmPUsername.types = NSSet(array: [typeServer])
        
        var rowAdmPPassword: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowAdmPPassword.key = "Adm.P.Password"
        rowAdmPPassword.value = ""
        rowAdmPPassword.section = "1"
        rowAdmPPassword.types = NSSet(array: [typeServer])
        
        var rowSupportURL: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowSupportURL.key = "Support URL"
        rowSupportURL.value = ""
        rowSupportURL.section = "1"
        rowSupportURL.types = NSSet(array: [typeServer])
        
        var rowSupport: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowSupport.key = "Support#"
        rowSupport.value = ""
        rowSupport.section = "1"
        rowSupport.types = NSSet(array: [typeServer])
        
        // MARK: - Save
        var error: NSError?
        if !moc.save(&error) {
            println("finish error: \(error!.localizedDescription)")
            abort()
        }
    }
}
