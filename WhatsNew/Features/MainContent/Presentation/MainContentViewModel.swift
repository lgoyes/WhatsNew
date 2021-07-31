//
//  ContentViewModel.swift
//  WhatsNew
//
//  Created by Luis Goyes Garces on 30/07/21.
//

import Foundation

protocol MainContentViewModelProtocol: AnyObject {
    func onRefreshButtonTapped()
    func onDeleteAllButtonTapped()
}

class MainContentViewModel {
    var state: MainContentState
    
    init() {
        self.state = MainContentState(
            segmentControlOptions: SegmentControlOption.allCases,
            selectedOption: SegmentControlOption.all)
    }
}

extension MainContentViewModel: MainContentViewModelProtocol {
    func onRefreshButtonTapped() {
        print("On refresh selected")
    }
    
    func onDeleteAllButtonTapped() {
        print("Deleting everything")
    }
}
