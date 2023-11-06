// DependencyInjectionContainer.swift
// Starter-iOS
//
// Created by Hasan Armoush on 06/11/2023.

import Swinject
import UIKit

final class DependencyInjectionContainer {
    
    static var shared = DependencyInjectionContainer()
    private let container = Container()
    
    private init() {
        registerNavigationController()
        registerAppStateManager()
        registerAuthenticationFeature()
        registerCoordinators()
    }
    
    private func registerNavigationController() {
        container.register(UINavigationController.self) { _ in
            UINavigationController()
        }.inObjectScope(.container)
        debugPrint("UINavigationController registered.")
    }
    
    private func registerAppStateManager() {
        container.register(AppLaunchStateManager.self) { _ in
            AppLaunchStateManager(defaults: UserDefaults.standard)
        }.inObjectScope(.container)
        debugPrint("AppLaunchStateManager registered.")
    }
    
    private func registerCoordinators() {
        container.register(MainCoordinator.self) { r in
            guard let navigationController = r.resolve(UINavigationController.self),
                  let appLaunchStateManager = r.resolve(AppLaunchStateManager.self) else {
                debugPrint("Failed to resolve dependencies for MainCoordinator.")
                fatalError("Dependencies not registered with container")
            }
            debugPrint("MainCoordinator dependencies resolved.")
            return MainCoordinator(
                navigationController: navigationController,
                appLaunchStateManager: appLaunchStateManager
            )
        }
        
        container.register(OnboardingCoordinator.self) { r in
            guard let navigationController = r.resolve(UINavigationController.self) else {
                debugPrint("Failed to resolve UINavigationController for OnboardingCoordinator.")
                fatalError("UINavigationController not registered with container")
            }
            debugPrint("OnboardingCoordinator dependencies resolved.")
            return OnboardingCoordinator(
                navigationController: navigationController
            )
        }
        
        container.register(AuthenticationCoordinator.self) { r in
            guard let navigationController = r.resolve(UINavigationController.self) else {
                debugPrint("Failed to resolve UINavigationController for AuthenticationCoordinator.")
                fatalError("UINavigationController not registered with container")
            }
            debugPrint("AuthenticationCoordinator dependencies resolved.")
            return AuthenticationCoordinator(
                navigationController: navigationController
            )
        }
    }
    
    private func registerAuthenticationFeature() {
        container.register(AuthenticationRemoteDataSource.self) { _ in AuthenticationRemoteDataSource() }
        debugPrint("AuthenticationRemoteDataSource registered.")
        
        container.register(AuthenticationLocalDataSource.self) { _ in AuthenticationLocalDataSource() }
        debugPrint("AuthenticationLocalDataSource registered.")
        
        container.register(UserRepository.self) { r in
            guard let remoteDataSource = r.resolve(AuthenticationRemoteDataSource.self),
                  let localDataSource = r.resolve(AuthenticationLocalDataSource.self) else {
                debugPrint("Failed to resolve dependencies for UserRepository.")
                fatalError("Dependencies not registered with container")
            }
            debugPrint("UserRepository dependencies resolved.")
            return UserRepository(remoteDataSource: remoteDataSource, localDataSource: localDataSource)
        }
        
        container.register(AuthenticationUseCase.self) { r in
            guard let repository = r.resolve(UserRepository.self) else {
                debugPrint("Failed to resolve UserRepository for AuthenticationUseCase.")
                fatalError("UserRepository not registered with container")
            }
            debugPrint("AuthenticationUseCase dependencies resolved.")
            return AuthenticationUseCase(repository: repository)
        }
        
        container.register(StandardValidationService.self) { _ in StandardValidationService() }
        debugPrint("StandardValidationService registered.")
        
        container.register(AuthenticationViewModel.self) { r in
            guard let authenticationUseCase = r.resolve(AuthenticationUseCase.self),
                  let validationService = r.resolve(StandardValidationService.self) else {
                debugPrint("Failed to resolve dependencies for AuthenticationViewModel.")
                fatalError("Dependencies not registered with container")
            }
            debugPrint("AuthenticationViewModel dependencies resolved.")
            return AuthenticationViewModel(authenticationUseCase: authenticationUseCase, validationService: validationService)
        }
        
        container.register(LoginViewController.self) { r in
            guard let viewModel = r.resolve(AuthenticationViewModel.self) else {
                debugPrint("Failed to resolve AuthenticationViewModel for LoginViewController.")
                fatalError("AuthenticationViewModel not registered with container")
            }
            debugPrint("LoginViewController dependencies resolved.")
            return LoginViewController(viewModel: viewModel)
        }
        
        container.register(RegisterViewController.self) { r in
            guard let viewModel = r.resolve(AuthenticationViewModel.self) else {
                debugPrint("Failed to resolve AuthenticationViewModel for RegisterViewController.")
                fatalError("AuthenticationViewModel not registered with container")
            }
            debugPrint("RegisterViewController dependencies resolved.")
            return RegisterViewController(viewModel: viewModel)
        }
    }
    
    func resolve<Service>(_ serviceType: Service.Type) -> Service? {
        guard let service = container.resolve(serviceType) else {
            debugPrint("Failed to resolve \(serviceType).")
            return nil
        }
        debugPrint("\(serviceType) resolved successfully.")
        return service
    }
}
