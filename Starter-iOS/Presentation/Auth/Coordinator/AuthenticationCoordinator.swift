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
        let validationService = StandardValidationService()
        let loginViewModel = AuthenticationViewModel(authenticationUseCase: usecase, validationService: validationService)
        let loginViewController = LoginViewController(viewModel: loginViewModel)
        loginViewController.coordinator = self
        navigationController.pushViewController(loginViewController, animated: true)
    }
    
    func showSignUp() {
        let remoteDataSource = AuthenticationRemoteDataSource()
        let localDataSource = AuthenticationLocalDataSource()
        let repository = UserRepository(remoteDataSource: remoteDataSource, localDataSource: localDataSource)
        let usecase = AuthenticationUseCase(repository: repository)
        let validationService = StandardValidationService()
        let viewModel = AuthenticationViewModel(authenticationUseCase: usecase, validationService: validationService)
        let viewController = RegisterViewController(viewModel: viewModel)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
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
