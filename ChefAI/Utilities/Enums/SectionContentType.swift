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
    
    init(for sectionIndex: Int) {
        switch sectionIndex {
        case 0:
            self = .dailyMeal
        case 1:
            self = .ingredientList
        case 2:
            self = .categoryList
        default:
            self = .mealList
        }
    }
}
