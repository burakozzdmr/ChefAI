//
//  MealModel.swift
//  ChefAI
//
//  Created by Burak Özdemir on 7.03.2025.
//

import Foundation

struct MealModel: Codable {
    let mealID: String?
    let mealName: String?
    let mealCategory: String?
    let mealArea: String?
    let mealInstructions: String?
    let mealImageURL: String?
    let mealYoutubeURL: String?
    var ingredients: [Ingredient]?
    
    enum CodingKeys: String, CodingKey {
        case mealID = "idMeal"
        case mealName = "strMeal"
        case mealCategory = "strCategory"
        case mealArea = "strArea"
        case mealInstructions = "strInstructions"
        case mealImageURL = "strMealThumb"
        case mealYoutubeURL = "strYoutube"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        // Decode main properties
        mealID = try container.decode(String.self, forKey: .mealID)
        mealName = try container.decode(String.self, forKey: .mealName)
        mealCategory = try container.decode(String.self, forKey: .mealCategory)
        mealArea = try container.decode(String.self, forKey: .mealArea)
        mealInstructions = try container.decode(String.self, forKey: .mealInstructions)
        mealImageURL = try container.decode(String.self, forKey: .mealImageURL)
        mealYoutubeURL = try container.decode(String.self, forKey: .mealYoutubeURL)
        
        // Decode ingredients and measures dynamically
        var ingredients: [Ingredient] = []
        let container2 = try decoder.container(keyedBy: DynamicCodingKeys.self)
        
        for i in 1...20 {
            let ingredientKey = DynamicCodingKeys(stringValue: "strIngredient\(i)")!
            let measureKey = DynamicCodingKeys(stringValue: "strMeasure\(i)")!
            
            if let ingredient = try container2.decodeIfPresent(String.self, forKey: ingredientKey),
               let measure = try container2.decodeIfPresent(String.self, forKey: measureKey),
               !ingredient.isEmpty,
               !measure.isEmpty {
                ingredients.append(Ingredient(name: ingredient, measure: measure))
            }
        }
        self.ingredients = ingredients
    }
}

// Helper for dynamic coding keys
private struct DynamicCodingKeys: CodingKey {
    var stringValue: String
    var intValue: Int?
    
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    init?(intValue: Int) {
        return nil
    }
}

struct Ingredient: Codable {
    let name: String
    let measure: String
}
