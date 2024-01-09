//
//  File.swift
//  
//
//  Created by Michael Iskandar on 09/01/24.
//

import UIKit
import UtilityKit
import ConnectionKit

class MealsViewController: UIViewController {
    
    @Inject var mealService: MealService
    
    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint("this is loaded")
        view.backgroundColor = .red
        
        mealService.searchMeals(q: "a")
            .subscribeOnNext { result in
                switch result {
                case .success(let meals):
                    debugPrint(meals)
                case .failure(let error):
                    debugPrint(error)
                }
            }
    }
}
