//
//  AppDelegate.swift
//  FoodMeals
//
//  Created by Michael Iskandar on 08/01/24.
//

import UIKit
import netfox
import ConnectionKit
import MealsKit
import UtilityKit
import CommonKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        NFX.sharedInstance().start()
        registerDependencies()
        initializeRoot()        
        return true
    }
}

extension AppDelegate {
    func initializeRoot() {
        window = UIWindow(frame: UIScreen.main.bounds)
        @Inject var mealFactory: MealFactory
        let viewController = mealFactory.makeMealViewController()
        let navController = UINavigationController(rootViewController: viewController)
        navController.title = "FoodMeals"
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
    
    func registerDependencies() {
        ConnectionKit.registerDependencies()
        MealsKit.registerDependencies()
    }
}
