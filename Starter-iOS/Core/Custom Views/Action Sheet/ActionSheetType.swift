//
//  ActionSheetType.swift
//  Starter-iOS
//
//  Created by Hasan Armoush on 02/11/2023.
//

import UIKit

enum ActionSheetType {
    case selection(items: [String], completion: (String) -> Void)
    case custom(title: String?, message: String?, actions: [UIAlertAction])
}
