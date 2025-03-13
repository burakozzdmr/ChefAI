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
