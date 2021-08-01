//
//  DevDBPostsRepository.swift
//  WhatsNew
//
//  Created by Luis Goyes Garces on 31/07/21.
//

import Foundation

class DevDBPostsRepository: DBPostsRepositoryType {
    var posts: [Post]
    init() {
        posts = [Post]()
        for i in (0..<3) {
            posts.append(
                Post(
                    id: i,
                    description: "Cached Description \(i)",
                    visited: false,
                    favorite: false)
            )
        }
    }
    
    func fetchEntries(_ callback: @escaping (Result<[Post], FetchNewPostsError>) -> ()) {
        callback(.success(posts))
    }
    func storePostsWithoutOverride(items: [Post]) {
        items.forEach { (newPost) in
            if posts.contains(where: { (oldPost) -> Bool in
                oldPost.id == newPost.id
            }) {
                // If the entry already exists, do not override
            } else {
                posts.append(newPost)
            }
        }
    }
}
