//
//  SettingsSectionType.swift
//  ChefAI
//
//  Created by Burak Özdemir on 12.04.2025.
//

import Foundation

enum SettingsSectionType {
    case privacyPolicy
    case rateUs
    case upgradeToPremium
    case logOut
    
    init(for sectionIndex: Int) {
        switch sectionIndex {
        case 0:
            self = .privacyPolicy
        case 1:
            self = .rateUs
        case 2:
            self = .upgradeToPremium
        default:
            self = .logOut
        }
    }
}
