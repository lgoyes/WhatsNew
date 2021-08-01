//
//  AllPostsState.swift
//  WhatsNew
//
//  Created by Luis Goyes Garces on 31/07/21.
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

struct Post: Identifiable {
    let id: Int
    let description: String
    let visited: Bool
    let favorite: Bool
    let fetchDate: Date
}

class AllPostsState: ObservableObject {
    @Published var posts: [Post]
    @Published var segmentControlOptions: [SegmentControlOption]
    @Published var selectedOption: SegmentControlOption
    @Published var errorMessage: String?
    @Published var presentingError: Bool
    @Published var loadingRequest: Bool
    @Published var postDetailSelected: Post!
    @Published var detailVisible: Bool
    init(segmentControlOptions: [SegmentControlOption], selectedOption: SegmentControlOption, posts: [Post], errorMessage: String?, presentingError: Bool, loadingRequest: Bool, postDetailSelected: Post?, detailVisible: Bool) {
        self.segmentControlOptions = segmentControlOptions
        self.selectedOption = selectedOption
        self.posts = posts
        self.errorMessage = errorMessage
        self.presentingError = presentingError
        self.loadingRequest = loadingRequest
        self.postDetailSelected = postDetailSelected
        self.detailVisible = detailVisible
    }
}
