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
    
    // keep current tabs
    var tabsModel = TabsModel()
    
    let TAG = "TabBarController"

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
        
    }
    
    // MARK: - ValuesTableViewController Delegate
    func newDataSaved() {
        configureTabs()
    }
    
    // MARK: - Helper Methods
    func configureTabs() {
        let fReq = NSFetchRequest(entityName: "SavedObject")
        
        var e: NSError? = nil
        if let fResults = self.managedObjectContext?.executeFetchRequest(fReq, error: &e) {
            if e != nil {
                println("\(TAG) fetch error: \(e!.localizedDescription)")
                abort()
            }
            
            if fResults.count > 0 {
                createTabs(fResults as! [SavedObject])
            }
        }
    }
    
    func createTabs(results: [SavedObject]) {
        
        var categoryArray = Array<Category>()
        
        for savedObject in results as [SavedObject] {
            categoryArray.append(savedObject.type.category)
        }
        
        // Get distinct categories
        let distinct = NSSet(array: categoryArray).allObjects as! [Category]
        
        for category in distinct {
            addNewTabWithCategory(category)
        }
    }
    
    func addNewTabWithCategory(category: Category) {
        
        // If the tab does not already exist
        if !contains(self.tabsModel.currentTabs, category.name) {

            // Select viewcontroller from storyboard
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let storyBoardID = "\(category.name)TVC"
            
            var navigationController = storyBoard.instantiateViewControllerWithIdentifier("navControllerForSelectedType") as! UINavigationController
            
            var selectedTypeView = storyBoard.instantiateViewControllerWithIdentifier("selectedTypeView") as! SelectedTypeTableViewController
            
            // Set selectedTypeView as root view controller
            navigationController.viewControllers[0] = selectedTypeView
            
            // Set tab bar item
            selectedTypeView.tabBarItem = UITabBarItem(title: category.name, image: UIImage(named: "tab_\(category.imageName)"), selectedImage: nil)
            
            // Set views's properties
            selectedTypeView.category = category
            selectedTypeView.managedObjectContext = self.managedObjectContext
            
            // Add view to tabs
            var tabs = self.viewControllers
            
            tabs?.append(navigationController)
            self.tabsModel.currentTabs.append(category.name)
            
            if tabs != nil {
                self.setViewControllers(tabs!, animated: true)
            }
        }
    }
}
