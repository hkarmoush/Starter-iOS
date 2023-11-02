//
//  AlertFactory.swift
//  Starter-iOS
//
//  Created by Hasan Armoush on 02/11/2023.
//

import UIKit

struct AlertFactory {
    
    static func create(type: AlertType) -> UIAlertController {
        switch type {
        case .confirmation(let message):
            return createConfirmationAlert(message: message)
        case .error(let message):
            return createErrorAlert(error: message)
        case .custom(let title, let message, let actions):
            return createCustomAlert(title: title, message: message, actions: actions)
        }
    }
    
    private static func createConfirmationAlert(message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Confirmation", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        return alert
    }
    
    private static func createErrorAlert(error: String) -> UIAlertController {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive, handler: nil))
        return alert
    }
    
    private static func createCustomAlert(title: String, message: String, actions: [UIAlertAction]) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        actions.forEach { alert.addAction($0) }
        return alert
    }
    
}
