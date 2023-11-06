//
//  LoginViewController.swift
//  Starter-iOS
//
//  Created by Hasan Armoush on 06/11/2023.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter your email"
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter your password"
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign In", for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        let disabledColorImage = UIImage.imageWithColor(.gray)
        button.setBackgroundImage(disabledColorImage, for: .disabled)
        return button
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Don't have an account? Register", for: .normal)
        button.backgroundColor = .clear
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(goToRegisterView), for: .touchUpInside)
        return button
    }()
    
    weak var coordinator: AuthenticationCoordinator?
    
    private var viewModel: AuthenticationViewModel!
    
    private let disposeBag = DisposeBag()
    
    init(viewModel: AuthenticationViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        bind()
    }
    
    private func setupViews() {
        setupEmailTextField()
        setupPasswordTextField()
        setupSignInButton()
        setupRegisterButton()
    }
    
    private func setupEmailTextField() {
        view.addSubview(emailTextField)
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupPasswordTextField() {
        view.addSubview(passwordTextField)
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 8),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupSignInButton() {
        view.addSubview(signInButton)
        NSLayoutConstraint.activate([
            signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            signInButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            signInButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    private func setupRegisterButton() {
        view.addSubview(registerButton)
        NSLayoutConstraint.activate([
            registerButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 16),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }
    
    func bind() {
        bindEmailTextField()
        bindPasswordTextField()
        bindSignInButtonEnabledState()
        bindSignInButtonTap()
    }
    
    private func bindEmailTextField() {
        emailTextField.rx.text.orEmpty
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)
    }
    
    private func bindPasswordTextField() {
        passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
    }
    
    private func bindSignInButtonEnabledState() {
        viewModel.isSignInActive
            .bind(to: signInButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }
    
    private func bindSignInButtonTap() {
        signInButton.rx.tap
            .flatMapLatest { [unowned self] in
                self.viewModel.signIn()
            }
            .subscribe(onNext: { [weak self] user in
                self?.handleSignInSuccess(user: user)
            }, onError: { [weak self] error in
                self?.handleSignInError(error: error)
            })
            .disposed(by: disposeBag)
    }
    
    private func handleSignInSuccess(user: User) {
        // Handle successful sign-in
    }
    
    private func handleSignInError(error: Error) {
        // Handle sign-in error
    }
    
    // MARK: - User Interaction
    @objc private func signInButtonTapped() {
        // This method can be used for additional actions, if needed
    }
    
    @objc private func goToRegisterView() {
        coordinator?.showSignUp()
    }
}
