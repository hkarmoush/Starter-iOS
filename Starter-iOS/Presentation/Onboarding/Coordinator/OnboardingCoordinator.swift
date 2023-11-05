//
//  MainCoordinator.swift
//  Starter-iOS
//
//  Created by Hasan Armoush on 05/11/2023.
//

import UIKit

class OnboardingCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    weak var parentCoordinator: MainCoordinator?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let onboardingViewModel = OnboardingViewModel()
        let onboardingViewController = OnboardingViewController(viewModel: onboardingViewModel)
        onboardingViewController.coordinatorDelegate = self
        navigationController.pushViewController(onboardingViewController, animated: true)
    }
    
    func didFinishOnboarding() {
        parentCoordinator?.childDidFinish(self)
    }
    
}
