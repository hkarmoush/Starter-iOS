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
        } 
//        else if appLaunchStateManager.isUserSignedIn {
//            showMainInterface()
//        } 
        else {
            showAuthentication()
        }
    }
    
    private func showOnboarding() {
        guard let coordinator = DIContainer.shared.resolve(OnboardingCoordinator.self) else { return }
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    private func showAuthentication() {
        guard let coordinator = DIContainer.shared.resolve(AuthenticationCoordinator.self) else { return }
        coordinator.delegate = self
        childCoordinators.append(coordinator)
        coordinator.start()
    }
    
    private func showMainInterface() {
        // Setup and show the main view controller...
    }
    
    func childDidFinish(_ child: Coordinator?) {
        if let child = child, let index = childCoordinators.firstIndex(where: { $0 === child }) {
            childCoordinators.remove(at: index)
        }
        // Decide what to show next after child coordinator finishes
        if child is OnboardingCoordinator {
            showAuthentication()
        } else if child is AuthenticationCoordinator {
            showMainInterface()
        }
    }
}

// Make MainCoordinator conform to AuthenticationCoordinatorDelegate
extension MainCoordinator: AuthenticationCoordinatorDelegate {
    func didCompleteAuthentication(in coordinator: AuthenticationCoordinator) {
        childDidFinish(coordinator)
        // Possibly handle post-authentication logic
    }
}
