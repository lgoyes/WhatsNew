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
    let fetchUserInteractor: FetchUserInteractable
    let fetchCommentsInteractor: FetchCommentsInteractable
    
    init(post: Post? = nil, context: NSManagedObjectContext? = nil) {
        self.state = PostDetailState(
            post: post,
            errorMessage: nil,
            presentingError: false,
            loadingRequest: false)
        
        var dbRepository: DBPostsRepositoryType!
        var userApiRepository: APIUserRepositoryType!
        var commentsApiRepository: APICommentsRepositoryType!
        #if DEBUG
        dbRepository = DevDBPostsRepository()
        userApiRepository = DevAPIUserRepository()
        commentsApiRepository = DevAPICommentsRepository()
        #else
        dbRepository = ProdDBPostsRepository(context: context)
        userApiRepository = ProdAPIUserRepository()
        commentsApiRepository = ProdAPICommentsRepository()
        #endif
        
        self.toggleFavoritePostInteractor = ToggleFavoritePostInteractor(dbRepository: dbRepository)
        self.fetchUserInteractor = FetchUserInteractor(apiRepository: userApiRepository)
        self.fetchCommentsInteractor = FetchCommentsInteractor(apiRepository: commentsApiRepository)
    }
    
    func fetchUser() {
        guard let post = self.state.post else {
            return
        }
        self.fetchUserInteractor.setParams(userId: post.userId)
        self.fetchUserInteractor.set { [weak self] (userResult) in
            guard let self = self else { return }
            switch userResult {
            case .success(let user):
                self.state.user = user
                self.state.errorMessage = nil
                self.state.presentingError = false
            case .failure(let error):
                print(error.localizedDescription)
                self.state.errorMessage = NSLocalizedString(LocalizedKey.Error.default, comment: "")
                self.state.presentingError = true
            }
        }
        self.fetchUserInteractor.execute()
    }
    
    func fetchComments() {
        guard let post = self.state.post else {
            return
        }
        self.fetchCommentsInteractor.setParams(postId: post.id)
        self.fetchCommentsInteractor.set { [weak self] (commentsResult) in
            guard let self = self else { return }
            switch commentsResult {
            case .success(let comments):
                self.state.comments = comments
                self.state.errorMessage = nil
                self.state.presentingError = false
            case .failure(let error):
                print(error.localizedDescription)
                self.state.errorMessage = NSLocalizedString(LocalizedKey.Error.default, comment: "")
                self.state.presentingError = true
            }
        }
        self.fetchCommentsInteractor.execute()
    }
}

extension PostDetailEntity: PostDetailEntityProtocol {
    func onViewAppeared() {
        if self.state.user == nil {
            fetchUser()
            fetchComments()
        }
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
