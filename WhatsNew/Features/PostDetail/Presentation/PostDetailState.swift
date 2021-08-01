//
//  PostDetailState.swift
//  WhatsNew
//
//  Created by Luis Goyes Garces on 1/08/21.
//

import Foundation

class PostDetailState: ObservableObject {
    @Published var post: Post?
    @Published var loadingRequest: Bool
    @Published var errorMessage: String?
    @Published var presentingError: Bool
    @Published var comments: [Comment]?
    @Published var user: User?
    
    init(post: Post?, errorMessage: String?, presentingError: Bool, loadingRequest: Bool, comments: [Comment]? = nil, user: User? = nil) {
        self.errorMessage = errorMessage
        self.presentingError = presentingError
        self.loadingRequest = loadingRequest
        self.post = post
        self.comments = comments
        self.user = user
    }
}
