//
//  AppLaunchStateManager.swift
//  Starter-iOS
//
//  Created by Hasan Armoush on 05/11/2023.
//

import Foundation

class AppLaunchStateManager: AppLaunchStateManaging {
    private let defaults: UserDefaults
    
    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }
    
    var isFirstLaunch: Bool {
        get {
            return defaults.bool(forKey: "isFirstLaunch")
        }
        set {
            defaults.set(newValue, forKey: "isFirstLaunch")
        }
    }
}
