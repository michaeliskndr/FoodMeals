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
    
    public func makeMealDetailViewController(id: String) -> UIViewController {
        let viewModel = MealsDetailViewModel()
        let viewController = MealsDetailViewController()
        
        viewController.viewModel = viewModel
        viewController.id = id
        return viewController
    }
    
    public func makeMealViewerController(image: UIImage) -> UIViewController {
        let viewController = MealViewerController()
        viewController.image = image
        return viewController
    }
}


