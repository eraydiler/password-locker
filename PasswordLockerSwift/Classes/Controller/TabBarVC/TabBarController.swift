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
                        ValuesTableViewControllerDelegate,
                        SelectedTypeTableViewControllerDelegate {
    
    // set by AppDelegate
//    var managedObjectContext: NSManagedObjectContext?

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
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    }
    
    // MARK: - ValuesTableViewController Delegate
    func newDataSaved() {
        configureTabs()
    }
    
    // MARK: - SelectedTypeTableViewController Delegate
    func allDataDeletedForCategory(_ category: Category) {
        removeTabWithCategory(category)
        configureTabs()
    }
    
    // MARK: - Helper Methods
    func configureTabs() {
        let fReq = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedObject")
        let managedObjectContext = NSManagedObjectContext.mr_default()

        var error: NSError? = nil
        do {
            let fResults = try managedObjectContext.fetch(fReq)

            if error != nil {
                print("\(TAG) fetch error: \(error!.localizedDescription)")
                abort()
            }
            
            if fResults.count > 0 {
                createTabs(fResults as! [SavedObject])
            }
        } catch let exception as NSError {
            error = exception
        }
    }
    
    // MARK: Create tabs
    func createTabs(_ results: [SavedObject]) {
        
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
    
    func addNewTabWithCategory(_ category: Category) {

        // If the tab does not already exist
        if !self.tabsModel.currentTabs.contains(category.name) {

            // Select viewcontroller from storyboard
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//            let storyBoardID = "\(category.name)TVC"
            
            let navigationController = storyBoard.instantiateViewController(withIdentifier: "navControllerForSelectedType") as! UINavigationController
            
            let selectedTypeViewController = storyBoard.instantiateViewController(withIdentifier: "selectedTypeView") as! SelectedTypeTableViewController
            
            // Set selectedTypeView as root view controller
            navigationController.viewControllers[0] = selectedTypeViewController
            
            // Set tab bar item
            selectedTypeViewController.tabBarItem = UITabBarItem(title: category.name,
                                                                 image: UIImage(named: "tab_\(category.imageName)"),
                                                                 selectedImage: nil)

            let managedObjectContext = NSManagedObjectContext.mr_default()

            // Set views's properties
            selectedTypeViewController.category = category
//            selectedTypeViewController.managedObjectContext = managedObjectContext
            selectedTypeViewController.delegate = self
            
            // Add view to tabs
            var tabs = self.viewControllers
            
            tabs?.append(navigationController)
            self.tabsModel.currentTabs.append(category.name)
            
            if tabs != nil {
                self.setViewControllers(tabs!, animated: true)
            }
        }
    }
    
    // MARK: Remove Tab
    func removeTabWithCategory(_ category: Category) {
        
        if let tabIndex = self.tabsModel.currentTabs.index(of: category.name) {
            self.tabsModel.currentTabs.remove(at: tabIndex)
            self.viewControllers?.remove(at: 2 + tabIndex)
            self.setViewControllers(self.viewControllers, animated: true)
        }
    }
}
