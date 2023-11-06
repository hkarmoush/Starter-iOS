//
//  UserDTO.swift
//  Starter-iOS
//
//  Created by Hasan Armoush on 06/11/2023.
//

import Foundation

struct UserDTO: Codable {
    let id: String
    let name: String
    let email: String

    func toEntity() -> User {
        return User(id: id, name: name, email: email)
    }
}
