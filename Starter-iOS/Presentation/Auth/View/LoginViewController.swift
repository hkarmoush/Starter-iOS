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
        setupBindings()
    }
    
    private func setupViews() {
        setupEmailTextField()
        setupPasswordTextField()
        setupSignInButton()
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
    
    private func setupBindings() {
        guard let viewModel = viewModel else { return }
        let emailValid = emailTextField.rx.text.orEmpty
            .flatMapLatest { [unowned self] email in
                self.validationService.validateEmail(email)
                    .startWith(false)
            }
        
        let passwordValid = passwordTextField.rx.text.orEmpty
            .flatMapLatest { [unowned self] password in
                self.validationService.validatePassword(password)
                    .startWith(false)
            }
        Observable.combineLatest(emailValid, passwordValid) { $0 && $1 }
            .bind(to: signInButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        signInButton.rx.tap
            .flatMapLatest { [unowned self] in
                self.viewModel.signIn()
            }
            .subscribe(onNext: { user in
                // Handle successful sign-in
            }, onError: { error in
                // Handle sign-in error
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - User Interaction
    @objc private func signInButtonTapped() {
        // This method can be used for additional actions, if needed
    }
}
