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
            self = .categoryList
        case 2:
            self = .mealList
        case 3:
            self = .breakfast
        case 4:
            self = .starter
        case 5:
            self = .meat
        case 6:
            self = .seafood
        case 7:
            self = .vegetarian
        case 8:
            self = .pasta
        default:
            self = .dessert
        }
    }
}
