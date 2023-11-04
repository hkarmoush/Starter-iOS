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
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let onboardingViewModel = OnboardingViewModel()
        let onboardingVC = OnboardingViewController(viewModel: onboardingViewModel)
        
        navigationController.pushViewController(onboardingVC, animated: true)
    }
    
    func finishOnboarding() {
        // Here you would handle the transition to the next part of your application
        // For example, if you have a MainAppCoordinator, you could start it here
    }
}
