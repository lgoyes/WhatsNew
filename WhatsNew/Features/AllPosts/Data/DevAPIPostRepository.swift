//
//  DevAPIPostRepository.swift
//  WhatsNew
//
//  Created by Luis Goyes Garces on 31/07/21.
//

import Foundation

class DevAPIPostRepository: APIPostsRepositoryType {
    private struct Constant {
        static let numberOfNewPosts = 20
    }
    
    func fetchEntries(_ callback: @escaping (Result<[Post], FetchNewPostsError>) -> ()) {
        var posts = [Post]()
        for i in (0..<30) {
            posts.append(
                Post(
                    id: i,
                    description: "Description \(i)",
                    visited: i >= Constant.numberOfNewPosts,
                    favorite: false,
                    fetchDate: Date())
            )
        }
        callback(.success(posts))
    }
}
