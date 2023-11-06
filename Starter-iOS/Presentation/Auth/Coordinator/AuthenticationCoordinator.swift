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
        let remoteDataSource = AuthenticationRemoteDataSource()
        let localDataSource = AuthenticationLocalDataSource()
        let repository = UserRepository(remoteDataSource: remoteDataSource, localDataSource: localDataSource)
        let usecase = AuthenticationUseCase(repository: repository)
        let loginViewModel = AuthenticationViewModel(authenticationUseCase: usecase)
        let loginViewController = LoginViewController(viewModel: loginViewModel)
        loginViewController.coordinator = self
        navigationController.pushViewController(loginViewController, animated: true)
    }
    
    func showSignUp() {
//        let signUpViewModel = AuthenticationViewModel(authenticationUseCase: YourAuthUseCaseImplementation())
//        let signUpViewController = SignUpViewController(viewModel: signUpViewModel)
//        signUpViewController.coordinator = self
//        navigationController.pushViewController(signUpViewController, animated: true)
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
