//
//  Coordinator.swift
//  Starter-iOS
//
//  Created by Hasan Armoush on 05/11/2023.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}
