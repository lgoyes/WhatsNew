//
//  DevAPIUserRepository.swift
//  WhatsNew
//
//  Created by Luis Goyes Garces on 1/08/21.
//

import Foundation

class DevAPIUserRepository: APIUserRepositoryType {
    func fetchUser(userId: Int, _ callback: @escaping (Result<User, FetchUserError>) -> ()) {
        let user = User(
            id: userId,
            name: "dummy",
            username: "username",
            email: "email",
            phone: "phone",
            website: "website")
        callback(.success(user))
    }
}
