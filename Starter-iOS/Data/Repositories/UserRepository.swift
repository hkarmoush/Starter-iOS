//
//  UserRepository.swift
//  Starter-iOS
//
//  Created by Hasan Armoush on 06/11/2023.
//

import RxSwift

class UserRepository: UserRepositoryProtocol {
    private let remoteDataSource: AuthenticationRemoteDataSource
    private let localDataSource: AuthenticationLocalDataSource

    init(remoteDataSource: AuthenticationRemoteDataSource, localDataSource: AuthenticationLocalDataSource) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }

    func signIn(_ email: String, password: String) -> Observable<User> {
        fatalError("not implemented")
    }

    func signUp(_ name: String, email: String, password: String) -> Observable<User> {
        fatalError("not implemented")
    }

    func recoverPassword(_ email: String) -> Observable<Void> {
        fatalError("not implemented")
    }
}
