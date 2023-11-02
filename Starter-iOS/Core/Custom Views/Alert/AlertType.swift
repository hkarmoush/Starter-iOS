//
//  AlertType.swift
//  Starter-iOS
//
//  Created by Hasan Armoush on 02/11/2023.
//

import UIKit

enum AlertType {
    case confirmation(message: String)
    case error(error: String)
    case custom(title: String, message: String, actions: [UIAlertAction])
}
