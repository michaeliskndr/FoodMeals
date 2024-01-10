//
//  File.swift
//  
//
//  Created by Michael Iskandar on 09/01/24.
//

import UIKit

public protocol MealRouting {
    func routeToMealDetail(from baseViewController: UIViewController, with id: String)
    func presentImage(from baseViewController: UIViewController, with image: UIImage)
}
