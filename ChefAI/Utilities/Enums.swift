//
//  Enums.swift
//  ChefAI
//
//  Created by Burak Özdemir on 9.03.2025.
//

import Foundation

// MARK: - DayPeriodType

enum DayPeriodType {
    case morning
    case afternoon
    case evening
    case night
    
    init() {
        let hour = Calendar.current.component(.hour, from: Date())
        
        switch hour {
        case 7..<12:
            self = .morning
        case 12..<18:
            self = .afternoon
        case 18..<22:
            self = .evening
        default:
            self = .night
        }
    }
}

// MARK: - CellSizeType

enum CellSizeType {
    case medium
    case large
    case vertical
    
    init(for sectionIndex: Int) {
        switch sectionIndex {
        case 0:
            self = .large
        case 1, 2, 3:
            self = .medium
        default:
            self = .vertical
        }
    }
}

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
