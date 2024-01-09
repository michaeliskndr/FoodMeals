//
//  File.swift
//  
//
//  Created by Michael Iskandar on 09/01/24.
//

import UIKit
import CommonKit

public class MealsKitFactory: MealFactory {
    public func makeMealViewController() -> UIViewController {
        return MealsViewController()
    }
    
    public func makeMealDetailViewController() -> UIViewController {
        // TODO: Add Meal Detail
        return UIViewController()
    }
    
    public func makeMealViewerController() -> UIViewController {
        // TODO: Add Meal Viewer
        return UIViewController()
    }
}


