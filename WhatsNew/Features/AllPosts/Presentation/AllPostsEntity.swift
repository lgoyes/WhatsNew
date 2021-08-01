//
//  AllPostsEntity.swift
//  WhatsNew
//
//  Created by Luis Goyes Garces on 31/07/21.
//

import Foundation
import CoreData

protocol AllPostsEntityProtocol: AnyObject {
    func onRefreshButtonTapped()
    func onDeleteAllButtonTapped()
    func onViewAppeared()
    func onRowSelected(post: Post) -> ()
    func onErrorDialogAction()
    func onDetailViewBackPressed()
}

class AllPostsEntity {
    var state: AllPostsState
    let fetchNewPostsInteractor: FetchNewPostsInteractable
    let clearCacheInteractor: ClearCacheInteractable
    let updateVisitedPostInteractor: UpdateVisitedPostInteractable
    
    init(state: AllPostsState = AllPostsState(
        segmentControlOptions: SegmentControlOption.allCases,
        selectedOption: SegmentControlOption.all,
        posts: [],
        errorMessage: nil,
        presentingError: false,
        loadingRequest: false,
        postDetailSelected: nil,
        detailVisible: false
    ),
    context: NSManagedObjectContext? = nil
    ) {
        self.state = state
        
        var dbRepository: DBPostsRepositoryType!
        var apiRepository: APIPostsRepositoryType!
        #if DEBUG
        dbRepository = DevDBPostsRepository()
        apiRepository = DevAPIPostRepository()
        #else
        dbRepository = ProdDBPostsRepository(context: context)
        apiRepository = ProdAPIPostsRepository()
        #endif
        
        self.fetchNewPostsInteractor = FetchNewPostsInteractor(
            apiRepository: apiRepository,
            dbRepository: dbRepository)
        self.clearCacheInteractor = ClearCacheInteractor(
            dbRepository: dbRepository)
        self.updateVisitedPostInteractor = UpdateVisitedPostInteractor(
            dbRepository: dbRepository)
    }
    
    func updateEntries() {
        self.state.loadingRequest = true
        fetchNewPostsInteractor.set { [weak self] (interactorResult) in
            guard let self = self else { return }
            self.state.loadingRequest = false
            switch interactorResult {
            case .success(let newPosts):
                newPosts.forEach { (newPost) in
                    if !self.state.posts.contains(where: { $0.id == newPost.id }) {
                        self.state.posts.append(newPost)
                    }
                }
                self.state.errorMessage = nil
                self.state.presentingError = false
            case .failure(_):
                self.state.posts = []
                self.state.errorMessage = NSLocalizedString(LocalizedKey.Error.default, comment: "")
                self.state.presentingError = true
            }
        }
        fetchNewPostsInteractor.execute()
    }
}

extension AllPostsEntity: AllPostsEntityProtocol {
    func onRefreshButtonTapped() {
        updateEntries()
    }
    
    func onViewAppeared() {
        if state.posts.isEmpty {
            updateEntries()
        }
    }
    
    func onDeleteAllButtonTapped() {
        self.state.posts = []
        clearCacheInteractor.execute()
    }
    
    func onRowSelected(post: Post) {
        updateVisitedPostInteractor.setParams(postId: post.id)
        updateVisitedPostInteractor.set { [weak self] (updatePostResponse) in
            guard let self = self else { return }
            
            switch updatePostResponse {
            case .success(let updatedPost):
                // I'm force unwrapping this post, as it must exist
                let updatedPostIndex = self.state.posts.firstIndex { $0.id == post.id }!
                self.state.posts[updatedPostIndex] = updatedPost
                
                self.state.postDetailSelected = post
                self.state.detailVisible = true
                self.state.presentingError = false
                self.state.errorMessage = nil
            case .failure(let error):
                print(error.localizedDescription)
                self.state.presentingError = true
                self.state.errorMessage = "Database error"
            }
        }
        updateVisitedPostInteractor.execute()
    }
    
    func onErrorDialogAction() {
        self.state.errorMessage = nil
    }
    
    func onDetailViewBackPressed() {
        self.state.postDetailSelected = nil
        self.state.detailVisible = false
    }
}
