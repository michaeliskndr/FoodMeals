//
//  File.swift
//  
//
//  Created by Michael Iskandar on 10/01/24.
//

import UIKit
import UtilityKit
import CommonKit

public struct MealsRouter: MealRouting {
    
    @Inject var mealFactory: MealFactory
    
    public func routeToMealDetail(from baseViewController: UIViewController, with id: String) {
        let vc = mealFactory.makeMealDetailViewController(id: id)
        baseViewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    public func presentImage(from baseViewController: UIViewController, with image: UIImage) {
        let vc = mealFactory.makeMealViewerController(image: image)
        vc.modalPresentationStyle = .fullScreen
        baseViewController.present(vc, animated: true)
    }
}
