//
//  ToggleFavoritePostInteractor.swift
//  WhatsNew
//
//  Created by Luis Goyes Garces on 1/08/21.
//

import Foundation

enum ToggleFavoritePostError: Swift.Error {
    case databaseError
    case missingParam
    case postNotFound
}

protocol ToggleFavoritePostInteractable {
    func setParams(postId: Int)
    func set(callback: @escaping (Result<Post, ToggleFavoritePostError>)->())
    func execute()
}

class ToggleFavoritePostInteractor: ToggleFavoritePostInteractable {
    var dbRepository: DBPostsRepositoryType
    var postIdToBeUpdated: Int?
    var callback: ((Result<Post, ToggleFavoritePostError>) -> ())?

    init(
        dbRepository: DBPostsRepositoryType
    ) {
        self.dbRepository = dbRepository
    }
    
    func setParams(postId: Int) {
        postIdToBeUpdated = postId
    }
    
    func set(callback: @escaping (Result<Post, ToggleFavoritePostError>) -> ()) {
        self.callback = callback
    }
    
    func execute() {
        guard let postId = self.postIdToBeUpdated else {
            callback?(.failure(.missingParam))
            return
        }
        
        dbRepository.getPostById(postId: postId) { (postFromDb) in
            guard let oldPost = postFromDb else {
                self.callback?(.failure(.postNotFound))
                return
            }
            
            let visitedPost = Post(
                id: oldPost.id,
                description: oldPost.description,
                body: oldPost.body,
                visited: oldPost.visited,
                favorite: !oldPost.favorite,
                fetchDate: Date(),
                userId: oldPost.userId)
            
            self.dbRepository.updatePost(postId: postId, post: visitedPost) { (updatedPost) in
                if let updatedPost = updatedPost {
                    self.callback?(.success(updatedPost))
                } else {
                    self.callback?(.failure(.databaseError))
                }
            }
        }
    }
}
