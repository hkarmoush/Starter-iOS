//
//  AuthenticationUseCaseProtocol.swift
//  Starter-iOS
//
//  Created by Hasan Armoush on 06/11/2023.
//

import RxSwift

protocol AuthenticationUseCaseProtocol {
    func signIn(email: String, password: String) -> Observable<User>
    func signUp(name: String, email: String, password: String) -> Observable<User>
    func recoverPassword(email: String) -> Observable<Void>
}
