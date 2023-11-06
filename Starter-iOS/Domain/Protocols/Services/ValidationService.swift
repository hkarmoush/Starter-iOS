//
//  ValidationService.swift
//  Starter-iOS
//
//  Created by Hasan Armoush on 06/11/2023.
//

import Foundation

protocol ValidationService {
    func validateEmail(_ email: String) -> Bool
    func validatePassword(_ password: String) -> Bool
}
