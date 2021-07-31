//
//  AllPostsEntity.swift
//  WhatsNew
//
//  Created by Luis Goyes Garces on 31/07/21.
//

import Foundation

protocol AllPostsEntityProtocol: AnyObject {
    func onRefreshButtonTapped()
    func onDeleteAllButtonTapped()
    func onViewAppeared()
    func onRowSelected(post: Post) -> ()
}

class AllPostsEntity {
    var state: AllPostsState
    let fetchNewPostsInteractor: FetchNewPostsInteractable
    
    init(state: AllPostsState = AllPostsState(
            segmentControlOptions: SegmentControlOption.allCases,
            selectedOption: SegmentControlOption.all,
            posts: [])) {
        self.state = state
        
        #if DEBUG
        self.fetchNewPostsInteractor = FetchNewPostsInteractor(
            apiRepository: DevAPIPostRepository(),
            dbRepository: DevDBPostsRepository())
        #else
        self.fetchNewPostsInteractor = FetchNewPostsInteractor(
            apiRepository: ProdAPIPostRepository(),
            dbRepository: ProdDBPostsRepository())
        #endif
    }
    
    func updateEntries() {
        if state.selectedOption == .all {
            getNewEntries()
        } else {
            
        }
    }
    
    func getNewEntries() {
        fetchNewPostsInteractor.set { [weak self] (interactorResult) in
            guard let self = self else { return }
            switch interactorResult {
            case .success(let posts):
                self.state.posts = posts
            case .failure(let error):
                self.state.posts = []
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
}
