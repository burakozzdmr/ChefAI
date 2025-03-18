//
//  SectionContentType.swift
//  ChefAI
//
//  Created by Burak Özdemir on 13.03.2025.
//

import Foundation

// MARK: - SectionContentType

enum SectionContentType {
    case dailyMeal
    case ingredientList
    case categoryList
    case mealList
    case breakfast
    case starter
    case meat
    case seafood
    case vegetarian
    case pasta
    case dessert
    
    init(for sectionIndex: Int) {
        switch sectionIndex {
        case 0:
            self = .dailyMeal
        case 1:
            self = .ingredientList
        case 2:
            self = .categoryList
        case 3:
            self = .mealList
        case 4:
            self = .breakfast
        case 5:
            self = .starter
        case 6:
            self = .meat
        case 7:
            self = .seafood
        case 8:
            self = .vegetarian
        case 9:
            self = .pasta
        default:
            self = .dessert
        }
    }
}
