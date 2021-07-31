//
//  MainContentState.swift
//  WhatsNew
//
//  Created by Luis Goyes Garces on 30/07/21.
//

import Foundation

enum SegmentControlOption: CaseIterable {
    case all
    case favorites
    func getLocalizedStringKey() -> String {
        switch self {
        case .all:
            return LocalizedKey.Main.SegmentControl.all
        case .favorites:
            return LocalizedKey.Main.SegmentControl.favorites
        }
    }
}

class MainContentState: ObservableObject {
    @Published var segmentControlOptions: [SegmentControlOption]
    @Published var selectedOption: SegmentControlOption
    init(segmentControlOptions: [SegmentControlOption], selectedOption: SegmentControlOption) {
        self.segmentControlOptions = segmentControlOptions
        self.selectedOption = selectedOption
    }
}
