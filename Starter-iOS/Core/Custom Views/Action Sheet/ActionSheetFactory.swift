//
//  ActionSheetFactory.swift
//  Starter-iOS
//
//  Created by Hasan Armoush on 02/11/2023.
//

import UIKit

struct ActionSheetFactory {
    
    static func create(type: ActionSheetType) -> UIAlertController {
        switch type {
        case .selection(let items, let completion):
            return createSelection(items: items, completion: completion)
        case .custom(let title, let message, let actions):
            return createCustom(title: title, message: message, actions: actions)
        }
    }
    
    private static func createSelection(items: [String], completion: @escaping (String) -> Void) -> UIAlertController {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        for item in items {
            let action = UIAlertAction(title: item, style: .default) { _ in completion(item) }
            actionSheet.addAction(action)
        }
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        return actionSheet
    }
    
    private static func createCustom(title: String?, message: String?, actions: [UIAlertAction]) -> UIAlertController {
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        actions.forEach { actionSheet.addAction($0) }
        return actionSheet
    }
    
}
