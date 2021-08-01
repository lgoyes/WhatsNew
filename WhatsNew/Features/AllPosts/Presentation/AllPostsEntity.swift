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
}

class AllPostsEntity {
    var state: AllPostsState
    let fetchNewPostsInteractor: FetchNewPostsInteractable
    
    init(state: AllPostsState = AllPostsState(
            segmentControlOptions: SegmentControlOption.allCases,
            selectedOption: SegmentControlOption.all,
            posts: [],
            errorMessage: nil,
            presentingError: false,
            loadingRequest: false
        ),
        context: NSManagedObjectContext? = nil
    ) {
        self.state = state
        
        #if DEBUG
        self.fetchNewPostsInteractor = FetchNewPostsInteractor(
            apiRepository: DevAPIPostRepository(),
            dbRepository: DevDBPostsRepository())
        #else
        self.fetchNewPostsInteractor = FetchNewPostsInteractor(
            apiRepository: ProdAPIPostsRepository(),
            dbRepository: ProdDBPostsRepository(context: context))
        #endif
    }
    
    func updateEntries() {
        self.state.loadingRequest = true
        fetchNewPostsInteractor.set { [weak self] (interactorResult) in
            guard let self = self else { return }
            self.state.loadingRequest = false
            switch interactorResult {
            case .success(let posts):
                self.state.posts = posts
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
        updateEntries()
    }
    
    func onDeleteAllButtonTapped() {
        self.state.posts = []
    }
    
    func onRowSelected(post: Post) {
        
    }
    
    func onErrorDialogAction() {
        self.state.errorMessage = nil
    }
}
