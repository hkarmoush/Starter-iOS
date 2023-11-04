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
            showMainInterface()
        }
    }
    
    private func showOnboarding() {
        let onboardingViewModel = OnboardingViewModel()
        let onboardingViewController = OnboardingViewController(viewModel: onboardingViewModel)
        onboardingViewController.coordinatorDelegate = self
        navigationController.pushViewController(onboardingViewController, animated: true)
    }
    
    private func showMainInterface() {
        // Setup the main view controller
        //        let homeViewController = HomeViewController()
        //        homeViewController.coordinator = self
        //        navigationController.setViewControllers([homeViewController], animated: false)
    }
}
