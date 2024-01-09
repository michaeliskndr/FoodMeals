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
        let viewModel = MealsViewModel()
        let viewController = MealsViewController()
        viewController.viewModel = viewModel
        return viewController
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


