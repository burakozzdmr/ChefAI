//
//  UIView+.swift
//  ChefAI
//
//  Created by Burak Özdemir on 11.04.2025.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
}
