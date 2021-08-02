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
                    body: "Cached Body \(i)",
                    visited: false,
                    favorite: false,
                    fetchDate: Date(),
                    userId: 1)
            )
        }
    }
    
    func fetchEntries(_ callback: @escaping (Result<[Post], FetchNewPostsError>) -> ()) {
        callback(.success(posts))
    }
    func storePostsWithoutOverride(items: [Post]) {
        items.forEach { (newPost) in
            if !posts.contains(where: { (oldPost) -> Bool in
                oldPost.id == newPost.id
            }) {
                posts.append(newPost)
            }
        }
    }
    func clearCache() {
        posts = []
    }
    func getPostById(postId: Int, callback: @escaping (Post?) -> ()) {
        let post = posts.first { $0.id == postId }
        callback(post)
    }
    func updatePost(postId: Int, post: Post, callback: @escaping (Post?) -> ()) {
        if let postIndex = posts.firstIndex(where: { $0.id == postId }) {
            posts[postIndex] = post
            callback(post)
        } else {
            callback(nil)
        }
    }
}
