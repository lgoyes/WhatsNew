//
//  FetchCommentsInteractor.swift
//  WhatsNew
//
//  Created by Luis Goyes Garces on 1/08/21.
//

import Foundation

enum FetchCommentsError: Swift.Error {
    case networkError
    case missingParam
    case unexpectedResponse
}

protocol FetchCommentsInteractable {
    func setParams(postId: Int)
    func set(callback: @escaping (Result<[Comment], FetchCommentsError>)->())
    func execute()
}

class FetchCommentsInteractor: FetchCommentsInteractable {
    var callback: ((Result<[Comment], FetchCommentsError>) -> ())?
    var apiRepository: APICommentsRepositoryType
    var postId: Int?
    
    init(
        apiRepository: APICommentsRepositoryType
    ) {
        self.apiRepository = apiRepository
    }
    
    func setParams(postId: Int) {
        self.postId = postId
    }
    
    func set(callback: @escaping (Result<[Comment], FetchCommentsError>) -> ()) {
        self.callback = callback
    }
    
    func execute() {
        guard let postId = self.postId else {
            callback?(.failure(.missingParam))
            return
        }
        
        if let callback = self.callback {
            apiRepository.fetchComments(postId: postId, callback)
        }
    }
}
