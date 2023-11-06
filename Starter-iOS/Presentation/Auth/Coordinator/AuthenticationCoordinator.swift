//
//  AuthenticationCoordinator.swift
//  Starter-iOS
//
//  Created by Hasan Armoush on 06/11/2023.
//

import UIKit

protocol AuthenticationCoordinatorDelegate: AnyObject {
    func didCompleteAuthentication(in coordinator: AuthenticationCoordinator)
}

class AuthenticationCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    weak var delegate: AuthenticationCoordinatorDelegate?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showLogin()
    }
    
    func showLogin() {
        guard let viewController = DependencyInjectionContainer.shared.resolve(LoginViewController.self) else {
            assertionFailure("LoginViewController could not be resolved")
            return
        }
        
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showSignUp() {
        if let viewController = DependencyInjectionContainer.shared.resolve(RegisterViewController.self) {
            viewController.coordinator = self
            navigationController.pushViewController(viewController, animated: true)
        }
    }
    
    func showPasswordRecovery() {
        //        let passwordRecoveryViewModel = AuthenticationViewModel(authenticationUseCase: YourAuthUseCaseImplementation())
        //        let passwordRecoveryViewController = PasswordRecoveryViewController(viewModel: passwordRecoveryViewModel)
        //        passwordRecoveryViewController.coordinator = self
        //        navigationController.pushViewController(passwordRecoveryViewController, animated: true)
    }
    
    func didFinishAuthentication() {
        delegate?.didCompleteAuthentication(in: self)
    }
    
    // Add any additional methods to handle navigation within the authentication flow...
}
