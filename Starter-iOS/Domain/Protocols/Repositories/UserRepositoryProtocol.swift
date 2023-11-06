//
//  UserRepositoryProtocol.swift
//  Starter-iOS
//
//  Created by Hasan Armoush on 06/11/2023.
//

import RxSwift

protocol UserRepositoryProtocol {
    func signIn(_ email: String, password: String) -> Observable<User>
    func signUp(_ name: String, email: String, password: String) -> Observable<User>
    func recoverPassword(_ email: String) -> Observable<Void>
}
