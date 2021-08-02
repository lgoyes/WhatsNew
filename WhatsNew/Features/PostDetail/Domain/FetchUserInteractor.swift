//
//  FetchUserInteractor.swift
//  WhatsNew
//
//  Created by Luis Goyes Garces on 1/08/21.
//

import Foundation

enum FetchUserError: Swift.Error {
    case networkError
    case missingParam
    case unexpectedResponse
}

protocol FetchUserInteractable {
    func setParams(userId: Int)
    func set(callback: @escaping (Result<User, FetchUserError>)->())
    func execute()
}

class FetchUserInteractor: FetchUserInteractable {
    var callback: ((Result<User, FetchUserError>) -> ())?
    var apiRepository: APIUserRepositoryType
    var userId: Int?
    
    init(
        apiRepository: APIUserRepositoryType
    ) {
        self.apiRepository = apiRepository
    }
    
    func setParams(userId: Int) {
        self.userId = userId
    }
    
    func set(callback: @escaping (Result<User, FetchUserError>) -> ()) {
        self.callback = callback
    }
    
    func execute() {
        guard let userId = self.userId else {
            callback?(.failure(.missingParam))
            return
        }
        
        if let callback = self.callback {
            apiRepository.fetchUser(userId: userId, callback)
        }
    }
    
}
