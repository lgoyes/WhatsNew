//
//  ContentViewModel.swift
//  WhatsNew
//
//  Created by Luis Goyes Garces on 30/07/21.
//

import Foundation

enum SegmentControlOption: String, CaseIterable {
    case all = "All"
    case favorites = "Favorites"
}

class MainContentState: ObservableObject {
    @Published var segmentControlOptions: [SegmentControlOption]
    @Published var selectedOption: SegmentControlOption
    init(segmentControlOptions: [SegmentControlOption], selectedOption: SegmentControlOption) {
        self.segmentControlOptions = segmentControlOptions
        self.selectedOption = selectedOption
    }
}

class MainContentViewModel {
    var state: MainContentState
    
    init() {
        self.state = MainContentState(
            segmentControlOptions: SegmentControlOption.allCases,
            selectedOption: SegmentControlOption.all)
    }
    
}
