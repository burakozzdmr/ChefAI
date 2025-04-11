//
//  UnderlineTextField.swift
//  ChefAI
//
//  Created by Burak Özdemir on 11.04.2025.
//

import UIKit

class UnderlineTextField: UITextField {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        let bottomLine = UIView()
        bottomLine.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: 3)
        bottomLine.backgroundColor = .customButton
        self.addSubview(bottomLine)
    }
}
