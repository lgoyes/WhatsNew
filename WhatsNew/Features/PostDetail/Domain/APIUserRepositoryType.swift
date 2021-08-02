//
//  APIUserRepositoryType.swift
//  WhatsNew
//
//  Created by Luis Goyes Garces on 1/08/21.
//

import Foundation

protocol APIUserRepositoryType: AnyObject {
    func fetchUser(userId: Int, _ callback: @escaping (Result<User, FetchUserError>) -> ())
}
