//
//  DevDBPostsRepository.swift
//  WhatsNew
//
//  Created by Luis Goyes Garces on 31/07/21.
//

import Foundation

class DevDBPostsRepository: DBPostsRepositoryType {
    var posts: [Post] = []
    init() {
        posts = [Post]()
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
        if let post = posts.first(where: { $0.id == postId }) {
            callback(post)
        } else {
            let post = Post(
                id: postId,
                description: "Cached Description \(postId)",
                body: "Cached Body \(postId)",
                visited: false,
                favorite: false,
                fetchDate: Date(),
                userId: 1)
            callback(post)
        }
    }
    func updatePost(postId: Int, post: Post, callback: @escaping (Post?) -> ()) {
        if let postIndex = posts.firstIndex(where: { $0.id == postId }) {
            posts[postIndex] = post
            callback(post)
        } else {
            posts.append(post)
            callback(post)
        }
    }
}
