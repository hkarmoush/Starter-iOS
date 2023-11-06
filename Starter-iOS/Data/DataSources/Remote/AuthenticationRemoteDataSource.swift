//
//  AuthenticationRemoteDataSource.swift
//  Starter-iOS
//
//  Created by Hasan Armoush on 06/11/2023.
//

import RxSwift

class AuthenticationRemoteDataSource {
    func authenticate(email: String, password: String) -> Observable<User> {
        fatalError("not implemented")
    }

    func register(name: String, email: String, password: String) -> Observable<User> {
        fatalError("not implemented")
    }

    func resetPassword(email: String) -> Observable<Void> {
        fatalError("not implemented")
    }
}
