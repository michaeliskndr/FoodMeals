//
//  File.swift
//  
//
//  Created by Michael Iskandar on 09/01/24.
//

import Foundation

public struct Meals: Codable {
    let meals: [Meal]
    
    enum CodingKeys: String, CodingKey {
        case meals
    }
}

public struct Meal: Codable {
    let id: String
    let meal: String
    let thumbnail: String
    let category: String
    let area: String
    let instructions: String?
    let ingredientOne: String?
    let ingredientTwo: String?
    let ingredientThree: String?
    let ingredientFour: String?
    let source: String?
    let measureOne: String?
    let measureTwo: String?
    let measureThree: String?
    let measureFour: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case meal = "strMeal"
        case thumbnail = "strMealThumb"
        case category = "strCategory"
        case area = "strArea"
        case instructions = "strInstructions"
        case ingredientOne = "strIngredient1"
        case ingredientTwo = "strIngredient2"
        case ingredientThree = "strIngredient3"
        case ingredientFour = "strIngredient4"
        case source = "strSource"
        case measureOne = "strMeasure1"
        case measureTwo = "strMeasure2"
        case measureThree = "strMeasure3"
        case measureFour = "strMeasure4"
    }
}
