//
//  FetchNewPostsInteractor.swift
//  WhatsNew
//
//  Created by Luis Goyes Garces on 31/07/21.
//

import Foundation

enum FetchNewPostsError: Swift.Error {
    
}

protocol FetchNewPostsInteractable {
    func set(callback: @escaping (Result<[Post], FetchNewPostsError>)->())
    func execute()
}

class FetchNewPostsInteractor: FetchNewPostsInteractable {
    var callback: ((Result<[Post], FetchNewPostsError>) -> ())?
    var apiRepository: APIPostsRepositoryType
    var dbRepository: DBPostsRepositoryType
    
    init(
        apiRepository: APIPostsRepositoryType,
        dbRepository: DBPostsRepositoryType
    ) {
        self.apiRepository = apiRepository
        self.dbRepository = dbRepository
    }
    
    func set(callback: @escaping (Result<[Post], FetchNewPostsError>) -> ()) {
        self.callback = callback
    }
    func execute() {
        apiRepository.fetchEntries { [weak self] (apiRepositoryResult) in
            switch apiRepositoryResult {
            case .success(let newPosts):
                self?.callback?(.success(newPosts))
            case .failure(let error):
                self?.callback?(.failure(error))
            }
            self?.callback = nil
        }
    }
}
