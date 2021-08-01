//
//  ClearCacheInteractor.swift
//  WhatsNew
//
//  Created by Luis Goyes Garces on 1/08/21.
//

import Foundation

enum ClearCacheError: Swift.Error {
    case databaseError
}

protocol ClearCacheInteractable {
    func set(callback: @escaping (Result<Void, ClearCacheError>)->())
    func execute()
}

class ClearCacheInteractor: ClearCacheInteractable {
    var callback: ((Result<Void, ClearCacheError>) -> ())?
    var dbRepository: DBPostsRepositoryType
    init(
        dbRepository: DBPostsRepositoryType
    ) {
        self.dbRepository = dbRepository
    }
    
    func set(callback: @escaping (Result<Void, ClearCacheError>) -> ()) {
        self.callback = callback
    }
    
    func execute() {
        dbRepository.clearCache()
        callback?(.success(()))
    }
    
}
