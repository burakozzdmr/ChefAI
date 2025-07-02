//
//  ChefFont.swift
//  ChefAI
//
//  Created by Burak Özdemir on 2.07.2025.
//

import Foundation

import Foundation
import UIKit

struct ChefFont {
    enum FontType: String {
        case Bold = "Bold"
        case Light = "Light"
        case Medium = "Medium"
        case Regular = "Regular"
        case SemiBold = "SemiBold"
    }

    static func font(type: FontType, size: CGFloat) -> UIFont{
        if let customFont = UIFont(name: "Fredoka-\(type.rawValue)", size: size) {
            return customFont
        } else {
            return .systemFont(ofSize: size)
        }
    }
}
