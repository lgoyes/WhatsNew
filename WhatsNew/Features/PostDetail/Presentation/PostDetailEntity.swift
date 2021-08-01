//
//  PostDetailEntity.swift
//  WhatsNew
//
//  Created by Luis Goyes Garces on 1/08/21.
//

import Foundation
import CoreData

protocol PostDetailEntityProtocol: AnyObject {
    func onViewAppeared()
    func onErrorDialogAction()
    func onFavoriteTapped()
}

class PostDetailEntity {
    var state: PostDetailState
    let toggleFavoritePostInteractor: ToggleFavoritePostInteractable
    
    init(post: Post? = nil, context: NSManagedObjectContext? = nil) {
        self.state = PostDetailState(
            post: post,
            errorMessage: nil,
            presentingError: false,
            loadingRequest: false)
        
        var dbRepository: DBPostsRepositoryType!
        var apiRepository: APIPostsRepositoryType!
        #if DEBUG
        dbRepository = DevDBPostsRepository()
        apiRepository = DevAPIPostRepository()
        #else
        dbRepository = ProdDBPostsRepository(context: context)
        apiRepository = ProdAPIPostsRepository()
        #endif
        
        self.toggleFavoritePostInteractor = ToggleFavoritePostInteractor(dbRepository: dbRepository)
    }
}

extension PostDetailEntity: PostDetailEntityProtocol {
    func onViewAppeared() {
        
    }
    
    func onErrorDialogAction() {
        self.state.errorMessage = nil
    }
    
    func onFavoriteTapped() {
        guard let post = self.state.post else {
            return
        }
        
        toggleFavoritePostInteractor.setParams(postId: post.id)
        toggleFavoritePostInteractor.set { [weak self] (updatePostResponse) in
            guard let self = self else { return }
            
            switch updatePostResponse {
            case .success(let updatedPost):
                self.state.post = updatedPost
                self.state.presentingError = false
                self.state.errorMessage = nil
            case .failure(let error):
                print(error.localizedDescription)
                self.state.presentingError = true
                self.state.errorMessage = "Database error"
            }
        }
        toggleFavoritePostInteractor.execute()
    }
}
