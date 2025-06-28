//
//  MealModel.swift
//  ChefAI
//
//  Created by Burak Özdemir on 7.03.2025.
//

import Foundation

struct MealModel: Codable {
    let meals: [Meal]
}

struct Meal: Codable {
    let mealID: String?
    let mealName: String?
    let mealCategory: String?
    let mealArea: String?
    let mealDescription: String?
    let mealImageURL: String?
    let mealTag: String?
    let mealYoutubeURL: String?
    
    enum CodingKeys: String, CodingKey {
        case mealID = "idMeal"
        case mealName = "strMeal"
        case mealCategory = "strCategory"
        case mealArea = "strArea"
        case mealDescription = "strInstructions"
        case mealImageURL = "strMealThumb"
        case mealTag = "strTags"
        case mealYoutubeURL = "strYoutube"
    }
}
