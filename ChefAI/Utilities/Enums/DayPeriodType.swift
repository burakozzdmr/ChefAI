//
//  DayPeriodType.swift
//  ChefAI
//
//  Created by Burak Özdemir on 13.03.2025.
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
