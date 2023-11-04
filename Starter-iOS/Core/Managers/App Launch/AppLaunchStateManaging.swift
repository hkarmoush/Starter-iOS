//
//  AppLaunchStateManaging.swift
//  Starter-iOS
//
//  Created by Hasan Armoush on 05/11/2023.
//

import Foundation

protocol AppLaunchStateManaging: AnyObject {
    var isFirstLaunch: Bool { get }
}
