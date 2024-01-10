//
//  File.swift
//  
//
//  Created by Michael Iskandar on 09/01/24.
//

import Foundation

public struct Meals: Codable, Hashable {
    public let meals: [Meal]?
    
    public init(meals: [Meal]?) {
        self.meals = meals
    }
    
    enum CodingKeys: String, CodingKey {
        case meals
    }
}

public struct Meal: Codable, Hashable {
    public let id: String
    public let meal: String
    public let thumbnail: String
    public let category: String
    public let tags: String?
    public let area: String
    public let instructions: String?
    public let ingredientOne: String?
    public let ingredientTwo: String?
    public let ingredientThree: String?
    public let ingredientFour: String?
    public let source: String?
    public let measureOne: String?
    public let measureTwo: String?
    public let measureThree: String?
    public let measureFour: String?
    
    public init(id: String,
         meal: String,
         thumbnail: String,
         category: String,
         tags: String?,
         area: String,
         instructions: String? = nil,
         ingredientOne: String? = nil,
         ingredientTwo: String? = nil,
         ingredientThree: String? = nil,
         ingredientFour: String? = nil,
         source: String? = nil,
         measureOne: String? = nil,
         measureTwo: String? = nil,
         measureThree: String? = nil,
         measureFour: String? = nil
    ) {
        self.id = id
        self.meal = meal
        self.thumbnail = thumbnail
        self.category = category
        self.tags = tags
        self.area = area
        self.instructions = instructions
        self.ingredientOne = ingredientOne
        self.ingredientTwo = ingredientTwo
        self.ingredientThree = ingredientThree
        self.ingredientFour = ingredientFour
        self.source = source
        self.measureOne = measureOne
        self.measureTwo = measureTwo
        self.measureThree = measureThree
        self.measureFour = measureFour
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case meal = "strMeal"
        case thumbnail = "strMealThumb"
        case category = "strCategory"
        case tags = "strTags"
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
