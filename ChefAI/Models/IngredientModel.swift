//
//  IngredientModel.swift
//  ChefAI
//
//  Created by Burak Özdemir on 11.03.2025.
//

import Foundation

struct IngredientModel: Codable {
    let ingredientList: [Ingredient]
    
    enum CodingKeys: String, CodingKey {
        case ingredientList = "meals"
    }
}

struct Ingredient: Codable {
    let ingredientID: String
    let ingredientName: String
    let ingredientDescription: String?
    let ingredientType: String?
    
    enum CodingKeys: String, CodingKey {
        case ingredientID = "idIngredient"
        case ingredientName = "strIngredient"
        case ingredientDescription = "strDescription"
        case ingredientType = "strType"
    }
}
