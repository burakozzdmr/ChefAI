//
//  AlertManager.swift
//  ChefAI
//
//  Created by Burak Özdemir on 3.06.2025.
//

import UIKit

class AlertManager {
    static let shared = AlertManager()
    
    private init() {}
    
    func presentAlert(with title: String,
                      and message: String,
                      buttons alertButtons: [UIAlertAction]? = nil,
                      from viewController: UIViewController
    ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if let safeAlertButtons = alertButtons {
            for button in safeAlertButtons {
                alertController.addAction(button)
            }
        } else {
            alertController.addAction(
                UIAlertAction(title: "Tamam", style: .default)
            )
        }
        viewController.present(alertController, animated: true)
    }
}
