//
//  CategoryType.swift
//  ChefAI
//
//  Created by Burak Özdemir on 16.03.2025.
//

import Foundation

// MARK: - CategoryType

enum CategoryType: String {
    case breakfast
    case starter
    case beef
    case chicken
    case seafood
    case vegetarian
    case pasta
    case dessert
    
    init(categoryText: String) {
        switch categoryText {
        case "Breakfast":
            self = .breakfast
        case "Starter":
            self = .starter
        case "Beef":
            self = .beef
        case "Chicken":
            self = .chicken
        case "Seafood":
            self = .seafood
        case "Vegetarian":
            self = .vegetarian
        case "Pasta":
            self = .pasta
        default:
            self = .dessert
        }
    }
}
