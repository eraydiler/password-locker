//
//  TabBarController.swift
//  PasswordLockerSwift
//
//  Created by Eray on 06/04/15.
//  Copyright (c) 2015 Eray. All rights reserved.
//

import UIKit
import CoreData

class TabBarController: UITabBarController,
                        UITabBarControllerDelegate,
                        ValuesTableViewControllerDelegate {
    
    // set by AppDelegate
    var managedObjectContext: NSManagedObjectContext?
    
    // saved data property
    var savedData: [SavedData]?
    
    // keep current tabs
    var tabsModel = TabsModel()

    func configureView() {
        
        // set UITabBarController delegate to self
        self.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureTabs()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITabBarController Delegate
    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController) {
        println("\(viewController) selected")
    }
    
    // MARK: - ValuesTableViewController Delegate
    func newDataSaved() {
        configureTabs()
    }
    
    // MARK: - Helper Methods
    func configureTabs() {
        let fReq = NSFetchRequest(entityName: "SavedData")
        
        var e: NSError? = nil
        if let fResults = self.managedObjectContext?.executeFetchRequest(fReq, error: &e) {
            if e != nil {
                println("fetch error: \(e!.localizedDescription)")
                abort()
            }
            
            if fResults.count > 0 {
                createTabs(fResults as [SavedData])
            }
        }
    }
    
    func createTabs(results: [SavedData]) {
        
        self.savedData = results
        var categoryArray = Array<Category>()
        
        for savedData in results as [SavedData] {
            categoryArray.append(savedData.type.category)
        }
        
        let distinct = NSSet(array: categoryArray).allObjects as [Category]
        
        for category in distinct {
            println(category.name)
            addNewTabForWithCategory(category)
        }
    }
    
    func addNewTabForWithCategory(category: Category) {
        
        // Select viewcontroller from storyboard
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let storyBoardID = "\(category.name)TVC"
        
        var newUIView = storyBoard.instantiateViewControllerWithIdentifier("selectedTypeView") as SelectedTypeTableViewController
        
        // Set tab bar item
        newUIView.tabBarItem = UITabBarItem(title: category.name, image: UIImage(named: "tab_\(category.imageName)"), selectedImage: nil)
        
        // Set views's properties
        newUIView.category = category
        newUIView.managedObjectContext = self.managedObjectContext
        
        // Add view to tabs
        var tabs = self.viewControllers        
        
        if !contains(self.tabsModel.currentTabs, category.name) {
            tabs?.append(newUIView)
            self.tabsModel.currentTabs.append(category.name)
        }
        if tabs != nil {
            self.setViewControllers(tabs!, animated: true)
        }
    }
}
