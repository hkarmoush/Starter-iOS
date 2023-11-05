//
//  MainCoordinator.swift
//  Starter-iOS
//
//  Created by Hasan Armoush on 05/11/2023.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    private let appLaunchStateManager: AppLaunchStateManaging
    
    init(navigationController: UINavigationController, appLaunchStateManager: AppLaunchStateManaging) {
        self.navigationController = navigationController
        self.appLaunchStateManager = appLaunchStateManager
    }
    
    func start() {
        if appLaunchStateManager.isFirstLaunch {
            showOnboarding()
        } else {
            showOnboarding()
        }
    }
    
    private func showOnboarding() {
        let coordinator = OnboardingCoordinator(navigationController: navigationController)
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    private func showMainInterface() {
        // Setup and show the main view controller, for example:
        //        let homeViewController = HomeViewController()
        //        homeViewController.coordinator = self
        //        navigationController.setViewControllers([homeViewController], animated: false)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        if let child = child, let index = childCoordinators.firstIndex(where: { $0 === child }) {
            childCoordinators.remove(at: index)
        }
        // Here you can decide if you need to show the main interface or something else
    }
}
