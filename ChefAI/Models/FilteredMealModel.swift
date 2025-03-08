//
//  FilteredMealsModel.swift
//  ChefAI
//
//  Created by Burak Özdemir on 7.03.2025.
//

import Foundation

struct FilteredMealModel: Codable {
    let mealName: String?
    let mealImageURL: String?
    let mealID: String?
    
    enum CodingKeys: String, CodingKey {
        case mealName = "strMeal"
        case mealImageURL = "strMealThumb"
        case mealID = "idMeal"
    }
}
