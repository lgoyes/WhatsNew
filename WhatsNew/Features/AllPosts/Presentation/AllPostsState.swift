//
//  AllPostsState.swift
//  WhatsNew
//
//  Created by Luis Goyes Garces on 31/07/21.
//

import Foundation

struct Post: Identifiable {
    let id: Int
    let description: String
    let visited: Bool
    let favorite: Bool
}

class AllPostsState: ObservableObject {
    @Published var posts: [Post]
    init(posts: [Post]) {
        self.posts = posts
    }
}
