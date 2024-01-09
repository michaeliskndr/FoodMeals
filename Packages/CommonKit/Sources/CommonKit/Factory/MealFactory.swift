//
//  File.swift
//  
//
//  Created by Michael Iskandar on 09/01/24.
//

import UIKit

public protocol MealFactory {
    func makeMealViewController() -> UIViewController
    func makeMealDetailViewController() -> UIViewController
    func makeMealViewerController() -> UIViewController
}
