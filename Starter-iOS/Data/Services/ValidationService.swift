//
//  ValidationService.swift
//  Starter-iOS
//
//  Created by Hasan Armoush on 06/11/2023.
//

import Foundation
import RxSwift

class StandardValidationService: ValidationServiceProtocol {
    
    func validateEmail(_ email: String) -> Observable<ValidationResult> {
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let isValid = NSPredicate(format:"SELF MATCHES %@", pattern).evaluate(with: email)
        return Observable.just(isValid ? .valid : .invalid("Invalid email format"))
    }
    
    func validatePassword(_ password: String) -> Observable<PasswordStrength> {
        let lengthRule = password.count >= 8
        let hasUpperCase = password.rangeOfCharacter(from: .uppercaseLetters) != nil
        let hasLowerCase = password.rangeOfCharacter(from: .lowercaseLetters) != nil
        let hasNumber = password.rangeOfCharacter(from: .decimalDigits) != nil
        let hasSymbol = password.rangeOfCharacter(from: .symbols) != nil || password.rangeOfCharacter(from: .punctuationCharacters) != nil
        
        var strengthScore = 0
        if lengthRule { strengthScore += 1 }
        if hasUpperCase { strengthScore += 1 }
        if hasLowerCase { strengthScore += 1 }
        if hasNumber { strengthScore += 1 }
        if hasSymbol { strengthScore += 1 }
        
        let strength: PasswordStrength
        switch strengthScore {
        case 1:
            strength = .weak
        case 2...3:
            strength = .medium
        default:
            strength = .strong
        }
        return Observable.just(strength)
    }
    
    func validatePhoneNumber(_ phoneNumber: String) -> Observable<ValidationResult> {
        let pattern = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let isValid = NSPredicate(format:"SELF MATCHES %@", pattern).evaluate(with: phoneNumber)
        return Observable.just(isValid ? .valid : .invalid("Invalid phone number"))
    }
    
    func validateUsername(_ username: String) -> Observable<ValidationResult> {
        let pattern = "^[\\w]{3,18}$" // Adjust pattern as needed
        let isValid = NSPredicate(format:"SELF MATCHES %@", pattern).evaluate(with: username)
        return Observable.just(isValid ? .valid : .invalid("Invalid username"))
    }
}
