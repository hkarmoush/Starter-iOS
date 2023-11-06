//
//  AuthenticationService.swift
//  Starter-iOS
//
//  Created by Hasan Armoush on 06/11/2023.
//

import RxSwift

protocol AuthenticationServiceProtocol {
    func authenticate(email: String, password: String) -> Observable<User>
    func register(name: String, email: String, password: String) -> Observable<User>
    func resetPassword(email: String) -> Observable<Void>
}
