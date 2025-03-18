//
//  CellSizeType.swift
//  ChefAI
//
//  Created by Burak Özdemir on 13.03.2025.
//

import Foundation

// MARK: - CellSizeType

enum CellSizeType {
    case medium
    case large
    
    init(for sectionIndex: Int) {
        switch sectionIndex {
        case 0:
            self = .large
        default:
            self = .medium
        }
    }
}
