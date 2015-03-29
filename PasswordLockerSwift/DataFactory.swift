//
//  DataFactory.swift
//  PasswordLockerSwift
//
//  Created by Eray on 17/03/15.
//  Copyright (c) 2015 Eray. All rights reserved.
//

import UIKit
import CoreData

class DataFactory: NSObject {
    
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
        typeRegular.imageName = "regular"
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
        typeDriverLicence.imageName = "driverLicence"
        typeDriverLicence.category = categoryWallet
        
        var typeMembership: Type = NSEntityDescription.insertNewObjectForEntityForName("Type", inManagedObjectContext: moc) as Type
        typeMembership.name = "Membership"
        typeMembership.imageName = "membership"
        typeMembership.category = categoryWallet
        
        var typePassport: Type = NSEntityDescription.insertNewObjectForEntityForName("Type", inManagedObjectContext: moc) as Type
        typePassport.name = "Passport"
        typePassport.imageName = "passport"
        typePassport.category = categoryWallet
        
        // MARK: - Note Type
        
        var typeNote: Type = NSEntityDescription.insertNewObjectForEntityForName("Type", inManagedObjectContext: moc) as Type
        typeNote.name = "Note"
        typeNote.imageName = "note"
        typeNote.category = categoryNote
        
        
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
        
        // Wireless Router header row
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
        
        // Note header row
        var rowNoteTitle: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowNoteTitle.key = "note"
        rowNoteTitle.value = "New Note"
        rowNoteTitle.section = "0"
        rowNoteTitle.types = NSSet(array: [typeNote])
        
        // Regular Mail header row
        var rowRegularMailTitle: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowRegularMailTitle.key = "regularMail"
        rowRegularMailTitle.value = "Regular Mail"
        rowRegularMailTitle.section = "0"
        rowRegularMailTitle.types = NSSet(array: [typeRegularMail])
        
        // Gmail header row
        var rowGmailTitle: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowGmailTitle.key = "gmail"
        rowGmailTitle.value = "Gmail"
        rowGmailTitle.section = "0"
        rowGmailTitle.types = NSSet(array: [typeGmail])
        
        // Hotmail header row
        var rowHotmailTitle: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowHotmailTitle.key = "hotmail"
        rowHotmailTitle.value = "Hotmail"
        rowHotmailTitle.section = "0"
        rowHotmailTitle.types = NSSet(array: [typeHotmail])
        
        // Yahoo header row
        var rowYahooMailTitle: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowYahooMailTitle.key = "yahoomail"
        rowYahooMailTitle.value = "Yahoo Mail"
        rowYahooMailTitle.section = "0"
        rowYahooMailTitle.types = NSSet(array: [typeYahooMail])
        
        // Bank Account header row
        var rowBankAccountTitle: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowBankAccountTitle.key = "bankAccount"
        rowBankAccountTitle.value = "Bank Account"
        rowBankAccountTitle.section = "0"
        rowBankAccountTitle.types = NSSet(array: [typeBankAccount])
        
        // Credit Card header row
        var rowCreditCardTitle: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowCreditCardTitle.key = "creditCard"
        rowCreditCardTitle.value = "Credit Card"
        rowCreditCardTitle.section = "0"
        rowCreditCardTitle.types = NSSet(array: [typeCreditCard])
        
        // ID header row
        var rowIDTitle: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowIDTitle.key = "id"
        rowIDTitle.value = "ID"
        rowIDTitle.section = "0"
        rowIDTitle.types = NSSet(array: [typeID])
        
        // Driver Licence header row
        var rowDriverLicenceTitle: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowDriverLicenceTitle.key = "driverLicence"
        rowDriverLicenceTitle.value = "Driver Licence"
        rowDriverLicenceTitle.section = "0"
        rowDriverLicenceTitle.types = NSSet(array: [typeDriverLicence])
        
        // Membership header row
        var rowMembershipTitle: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowMembershipTitle.key = "membership"
        rowMembershipTitle.value = "Membersip"
        rowMembershipTitle.section = "0"
        rowMembershipTitle.types = NSSet(array: [typeMembership])
        
        // Passport header row
        var rowPassportTitle: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowPassportTitle.key = "passport"
        rowPassportTitle.value = "Passport"
        rowPassportTitle.section = "0"
        rowPassportTitle.types = NSSet(array: [typePassport])
        
        // Regular header row
        var rowRegularTitle: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowRegularTitle.key = "regular"
        rowRegularTitle.value = "Regular"
        rowRegularTitle.section = "0"
        rowRegularTitle.types = NSSet(array: [typeRegular])
        
        // Facebook header row
        var rowFacebookTitle: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowFacebookTitle.key = "facebook"
        rowFacebookTitle.value = "Facebook"
        rowFacebookTitle.section = "0"
        rowFacebookTitle.types = NSSet(array: [typeFacebook])
        
        // Google header row
        var rowGoogleTitle: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowGoogleTitle.key = "google"
        rowGoogleTitle.value = "Google"
        rowGoogleTitle.section = "0"
        rowGoogleTitle.types = NSSet(array: [typeGoogle])
        
        // Twitter header row
        var rowTwitterTitle: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowTwitterTitle.key = "twitter"
        rowTwitterTitle.value = "Twitter"
        rowTwitterTitle.section = "0"
        rowTwitterTitle.types = NSSet(array: [typeTwitter])
        
        // Instagram header row
        var rowInstagramTİtle: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowInstagramTİtle.key = "instagram"
        rowInstagramTİtle.value = "Instagram"
        rowInstagramTİtle.section = "0"
        rowInstagramTİtle.types = NSSet(array: [typeInstagram])
        
        // Flickr header row
        var rowFlickrTitle: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowFlickrTitle.key = "flickr"
        rowFlickrTitle.value = "Flickr"
        rowFlickrTitle.section = "0"
        rowFlickrTitle.types = NSSet(array: [typeFlickr])
        
        // Youtube header row
        var rowYoutubeTitle: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowYoutubeTitle.key = "youtube"
        rowYoutubeTitle.value = "Youtube"
        rowYoutubeTitle.section = "0"
        rowYoutubeTitle.types = NSSet(array: [typeYoutube])
        
        // Linkedin header row
        var rowLinkedinTitle: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowLinkedinTitle.key = "linkedin"
        rowLinkedinTitle.value = "Linkedin"
        rowLinkedinTitle.section = "0"
        rowLinkedinTitle.types = NSSet(array: [typeLinkedin])
        
        // Yahoo header row
        var rowYahooTitle: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowYahooTitle.key = "yahoo"
        rowYahooTitle.value = "Yahoo"
        rowYahooTitle.section = "0"
        rowYahooTitle.types = NSSet(array: [typeYahoo])
        
        // Paypal header row
        var rowPaypalTitle: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowPaypalTitle.key = "paypal"
        rowPaypalTitle.value = "Paypal"
        rowPaypalTitle.section = "0"
        rowPaypalTitle.types = NSSet(array: [typePaypal])
        
        // Amazon header row
        var rowAmazonTitle: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowAmazonTitle.key = "amazon"
        rowAmazonTitle.value = "Amazon"
        rowAmazonTitle.section = "0"
        rowAmazonTitle.types = NSSet(array: [typeAmazon])
        
        // Ebay header row
        var rowEbayTitle: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowEbayTitle.key = "ebay"
        rowEbayTitle.value = "Ebay"
        rowEbayTitle.section = "0"
        rowEbayTitle.types = NSSet(array: [typeEbay])
        
        // Wordpress header row
        var rowWordpressTitle: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowWordpressTitle.key = "wordpress"
        rowWordpressTitle.value = "Wordpress"
        rowWordpressTitle.section = "0"
        rowWordpressTitle.types = NSSet(array: [typeWordpress])        
        
        // end of headers
        
        
        var rowUsername: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowUsername.key = "Username"
        rowUsername.value = ""
        rowUsername.section = "1"
        rowUsername.types = NSSet(array: Array<Type>([typeGenericAcc, typeDatabase, typeFtpServer, typeServer, typeRegularMail, typeGmail, typeHotmail, typeYahooMail, typeRegular, typeFacebook, typeGoogle, typeTwitter, typeInstagram, typeFlickr, typeYoutube, typeLinkedin, typeYahoo, typePaypal, typeAmazon, typeEbay, typeWordpress])
)
        
        var rowPassword: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowPassword.key = "Password"
        rowPassword.value = ""
        rowPassword.section = "1"
        rowPassword.types = NSSet(array: Array<Type>([typeGenericAcc, typeInstnMssngr, typeDatabase, typeFtpServer, typeWirelessRtr, typeServer, typeRegularMail, typeGmail, typeHotmail, typeYahooMail, typeMembership, typeRegular, typeFacebook, typeGoogle, typeTwitter, typeInstagram, typeFlickr, typeYoutube, typeLinkedin, typeYahoo, typePaypal, typeAmazon, typeEbay, typeWordpress]))

        var rowNote: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowNote.key = "note"
        rowNote.value = "No Note"
        rowNote.section = "2"
        rowNote.types = NSSet(array: Array<Type>([typeGenericAcc, typeInstnMssngr, typeDatabase, typeFtpServer, typeSoftwrLcnc, typeWirelessRtr, typeServer, typeRegularMail, typeGmail, typeHotmail, typeYahooMail, typeBankAccount, typeID, typePassport, typeRegular, typeFacebook, typeGoogle, typeTwitter, typeInstagram, typeFlickr, typeYoutube, typeLinkedin, typeYahoo, typePaypal, typeAmazon, typeEbay, typeWordpress]))
        
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
        rowType.types = NSSet(array: Array<Type>([typeDatabase, typeBankAccount, typeCreditCard]))
        
        var rowServer: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowServer.key = "Server"
        rowServer.value = ""
        rowServer.section = "1"
        rowServer.types = NSSet(array: Array<Type>([typeDatabase, typeFtpServer, typeRegularMail, typeGmail, typeHotmail, typeYahooMail]))

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
        rowWebsite.types = NSSet(array: Array<Type>([typeFtpServer, typeMembership]))

        var rowPhone: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowPhone.key = "Phone"
        rowPhone.value = ""
        rowPhone.section = "1"
        rowPhone.types = NSSet(array: [typeFtpServer])
        
        var rowStation: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowStation.key = "Station"
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
        rowUrl.types = NSSet(array: Array<Type>([typeServer, typeRegular, typeFacebook, typeGoogle, typeTwitter, typeInstagram, typeFlickr, typeYoutube, typeLinkedin, typeYahoo, typePaypal, typeAmazon, typeEbay, typeWordpress]))
        
        var rowName: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowName.key = "Name"
        rowName.value = ""
        rowName.section = "1"
        rowName.types = NSSet(array: Array<Type>([typeServer, typeID, typeMembership, typePassport]))
        
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
        
        var rowServerType: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowServerType.key = "Server Type"
        rowServerType.value = ""
        rowServerType.section = "1"
        rowServerType.types = NSSet(array: Array<Type>([typeRegularMail, typeGmail, typeHotmail, typeYahooMail]))

        var rowSmtpServer: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowSmtpServer.key = "SMTP Server"
        rowSmtpServer.value = ""
        rowSmtpServer.section = "1"
        rowSmtpServer.types = NSSet(array: Array<Type>([typeRegularMail, typeGmail, typeHotmail, typeYahooMail]))

        var rowWebmail: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowWebmail.key = "Webmail"
        rowWebmail.value = ""
        rowWebmail.section = "1"
        rowWebmail.types = NSSet(array: Array<Type>([typeRegularMail, typeGmail, typeHotmail, typeYahooMail]))
        
        var rowBankName: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowBankName.key = "Bank Name"
        rowBankName.value = ""
        rowBankName.section = "1"
        rowBankName.types = NSSet(array: [typeBankAccount])
        
        var rowOwner: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowOwner.key = "Owner"
        rowOwner.value = ""
        rowOwner.section = "1"
        rowOwner.types = NSSet(array: Array<Type>([typeBankAccount, typeCreditCard]))
        
        var rowAccount: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowAccount.key = "Account#"
        rowAccount.value = ""
        rowAccount.section = "1"
        rowAccount.types = NSSet(array: [typeBankAccount])
        
        var rowPin: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowPin.key = "PIN"
        rowPin.value = ""
        rowPin.section = "1"
        rowPin.types = NSSet(array: Array<Type>([typeBankAccount, typeCreditCard]))
        
        var rowSwift: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowSwift.key = "Swift"
        rowSwift.value = ""
        rowSwift.section = "1"
        rowSwift.types = NSSet(array: [typeBankAccount])
        
        var rowIban: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowIban.key = "IBAN"
        rowIban.value = ""
        rowIban.section = "1"
        rowIban.types = NSSet(array: [typeBankAccount])
        
        var rowNumber: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowNumber.key = "Number"
        rowNumber.value = ""
        rowNumber.section = "1"
        rowNumber.types = NSSet(array: Array<Type>([typeCreditCard, typeID, typeDriverLicence, typeMembership, typePassport]))
        
        var rowCardHolder: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowCardHolder.key = "Cardholder"
        rowCardHolder.value = ""
        rowCardHolder.section = "1"
        rowCardHolder.types = NSSet(array: [typeCreditCard])
        
        var rowValid: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowValid.key = "Valid"
        rowValid.value = ""
        rowValid.section = "1"
        rowValid.types = NSSet(array: [typeCreditCard])
        
        var rowCvc: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowCvc.key = "CVC"
        rowCvc.value = ""
        rowCvc.section = "1"
        rowCvc.types = NSSet(array: [typeCreditCard])
        
        var rowDateOfBirth: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowDateOfBirth.key = "Date of birth"
        rowDateOfBirth.value = ""
        rowDateOfBirth.section = "1"
        rowDateOfBirth.types = NSSet(array: Array<Type>([typeID, typePassport]))
        
        var rowPlaceOfBirth: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowPlaceOfBirth.key = "Place of birth"
        rowPlaceOfBirth.value = ""
        rowPlaceOfBirth.section = "1"
        rowPlaceOfBirth.types = NSSet(array: Array<Type>([typeID, typePassport]))
        
        var rowDateOfIssue: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowDateOfIssue.key = "Date of issue"
        rowDateOfIssue.value = ""
        rowDateOfIssue.section = "1"
        rowDateOfIssue.types = NSSet(array: Array<Type>([typeID, typeDriverLicence, typePassport]))
        
        var rowDateOfExpiry: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowDateOfExpiry.key = "Date of Expiry"
        rowDateOfExpiry.value = ""
        rowDateOfExpiry.section = "1"
        rowDateOfExpiry.types = NSSet(array: Array<Type>([typeID, typeDriverLicence, typePassport]))
        
        var rowFullName: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowFullName.key = "Full Name"
        rowFullName.value = ""
        rowFullName.section = "1"
        rowFullName.types = NSSet(array: [typeDriverLicence])
        
        var rowVehicleTypes: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowVehicleTypes.key = "Vehicle Types"
        rowVehicleTypes.value = ""
        rowVehicleTypes.section = "1"
        rowVehicleTypes.types = NSSet(array: [typeDriverLicence])
        
        var rowOrg: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowOrg.key = "Org"
        rowOrg.value = ""
        rowOrg.section = "1"
        rowOrg.types = NSSet(array: [typeMembership])
        
        var rowTelephone: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowTelephone.key = "Telephone"
        rowTelephone.value = ""
        rowTelephone.section = "1"
        rowTelephone.types = NSSet(array: [typeMembership])
        
        var rowSince: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowSince.key = "Since"
        rowSince.value = ""
        rowSince.section = "1"
        rowSince.types = NSSet(array: [typeMembership])
        
        var rowExpires: Row = NSEntityDescription.insertNewObjectForEntityForName("Row", inManagedObjectContext: moc) as Row
        rowExpires.key = "Expires"
        rowExpires.value = ""
        rowExpires.section = "1"
        rowExpires.types = NSSet(array: [typeMembership])
        
        // MARK: - Save
        var error: NSError?
        if !moc.save(&error) {
            println("finish error: \(error!.localizedDescription)")
            abort()
        }
    }
    
    class func deleteAllObjects(managedObjectContext: NSManagedObjectContext, entityDescription: String) {
        
        let entity = NSEntityDescription.entityForName(entityDescription, inManagedObjectContext: managedObjectContext)
        let req = NSFetchRequest()
        req.entity = entity

        // perform initial model fetch
        var e: NSError?
        if let items = managedObjectContext.executeFetchRequest(req, error: &e) {
            for object in items {
                managedObjectContext.deleteObject(object as NSManagedObject)
                println("\(object) object deleted")
            }
            if !managedObjectContext.save(&e) {
                println("Error deleting \(entityDescription) - error:\(e)")
            }
        }
    }
}
