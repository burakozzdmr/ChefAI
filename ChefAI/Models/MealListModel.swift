//
//  MealList.swift
//  ChefAI
//
//  Created by Burak Özdemir on 13.03.2025.
//

import Foundation

struct MealListModel: Codable {
    let meals: [MealList]
}

struct MealList: Codable {
    let mealName: String?
    let mealImageURL: String?
    let mealID: String?
    
    enum CodingKeys: String, CodingKey {
        case mealName = "strMeal"
        case mealImageURL = "strMealThumb"
        case mealID = "idMeal"
    }
}
