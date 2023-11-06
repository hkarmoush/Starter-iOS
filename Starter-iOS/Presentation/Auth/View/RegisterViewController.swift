//
//  RegisterViewController.swift
//  Starter-iOS
//
//  Created by Hasan Armoush on 06/11/2023.
//
import UIKit
import RxSwift
import RxCocoa

class RegisterViewController: UIViewController {
    
    private lazy var nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter your name"
        textField.autocapitalizationType = .words
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
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
    
    private lazy var confirmPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Confirm your password"
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Register", for: .normal)
        button.backgroundColor = UIColor.systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        let disabledColorImage = UIImage.imageWithColor(color: .gray)
        button.setBackgroundImage(disabledColorImage, for: .disabled)
        return button
    }()
    
    private var viewModel: AuthenticationViewModel!
    private let disposeBag = DisposeBag()
    
    weak var coordinator: AuthenticationCoordinator?
    
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
        setupNameTextField()
        setupEmailTextField()
        setupPasswordTextField()
        setupConfirmPasswordTextField()
        setupRegisterButton()
    }
    
    private func setupNameTextField() {
        view.addSubview(nameTextField)
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupEmailTextField() {
        view.addSubview(emailTextField)
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 8),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupPasswordTextField() {
        view.addSubview(passwordTextField)
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 8),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupConfirmPasswordTextField() {
        view.addSubview(confirmPasswordTextField)
        NSLayoutConstraint.activate([
            confirmPasswordTextField.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 8),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            confirmPasswordTextField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupRegisterButton() {
        view.addSubview(registerButton)
        NSLayoutConstraint.activate([
            registerButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 20),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            registerButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupBindings() {
        nameTextField.rx.text.orEmpty
            .bind(to: viewModel.name)
            .disposed(by: disposeBag)
        
        emailTextField.rx.text.orEmpty
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
        
        viewModel.isSignUpActive
            .bind(to: registerButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        // Handle the register button tap
        registerButton.rx.tap
            .flatMapLatest { [unowned self] in
                self.viewModel.signUp()
            }
            .subscribe(onNext: { [weak self] user in
                // Handle successful registration
            }, onError: { [weak self] error in
                // Handle registration error
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - User Interaction
    @objc private func registerButtonTapped() {
        // This method can be used for additional actions, if needed
    }
}

extension UIImage {
    static func imageWithColor(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
