//
//  AuthenticationUseCase.swift
//  Starter-iOS
//
//  Created by Hasan Armoush on 06/11/2023.
//

import RxSwift

class AuthenticationUseCase: AuthenticationUseCaseProtocol {
    private let repository: UserRepositoryProtocol

    init(repository: UserRepositoryProtocol) {
        self.repository = repository
    }

    func signIn(email: String, password: String) -> Observable<User> {
        repository.signIn(email, password: password)
    }

    func signUp(name: String, email: String, password: String) -> Observable<User> {
        repository.signUp(name, email: email, password: password)
    }

    func recoverPassword(email: String) -> Observable<Void> {
        repository.recoverPassword(email)
    }
}
