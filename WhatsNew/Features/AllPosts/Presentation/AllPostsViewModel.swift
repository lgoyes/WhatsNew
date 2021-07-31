//
//  AllPostsViewModel.swift
//  WhatsNew
//
//  Created by Luis Goyes Garces on 31/07/21.
//

import Foundation

protocol AllPostsViewModelProtocol: AnyObject {
    func onRefreshButtonTapped()
    func onDeleteAllButtonTapped()
    func onViewAppeared()
}

class AllPostsViewModel {
    var state: AllPostsState
    
    init(state: AllPostsState = AllPostsState(
            segmentControlOptions: SegmentControlOption.allCases,
            selectedOption: SegmentControlOption.all,
            posts: [])) {
        self.state = state
    }
}

extension AllPostsViewModel: AllPostsViewModelProtocol {
    func onRefreshButtonTapped() {
        print("On refresh selected")
    }
    
    func onViewAppeared() {
        
    }
    
    func onDeleteAllButtonTapped() {
        print("On delete selected")
    }
}
