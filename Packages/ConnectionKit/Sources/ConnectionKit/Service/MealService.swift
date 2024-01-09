//
//  File.swift
//  
//
//  Created by Michael Iskandar on 09/01/24.
//

import Foundation
import CommonKit

public protocol MealService {
    func searchMeals(q: String) -> APIResponse<Meals>
    func getMealsDetail(id: String) -> APIResponse<Meals>
}

public class MealAPI: BaseAPI, MealService {
    public func searchMeals(q: String) -> APIResponse<Meals> {
        request(.get, endpoint: "/search.php", payload: ["s": q])
    }
    
    public func getMealsDetail(id: String) -> APIResponse<Meals> {
        request(.get, endpoint: "/lookup.php", payload: ["i": id])
    }
}
