//
//  ValidationService.swift
//  Starter-iOS
//
//  Created by Hasan Armoush on 06/11/2023.
//

import RxSwift

protocol ValidationServiceProtocol {
    func validateEmail(_ email: String) -> Observable<ValidationResult>
    func validatePassword(_ password: String) -> Observable<PasswordStrength>
    func validatePhoneNumber(_ phoneNumber: String) -> Observable<ValidationResult>
    func validateUsername(_ username: String) -> Observable<ValidationResult>
}

enum PasswordStrength {
    case weak
    case medium
    case strong
}

enum ValidationResult {
    case valid
    case invalid(String)
}
