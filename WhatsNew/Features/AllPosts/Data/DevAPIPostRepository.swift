//
//  DevAPIPostRepository.swift
//  WhatsNew
//
//  Created by Luis Goyes Garces on 31/07/21.
//

import Foundation

class DevAPIPostRepository: APIPostsRepositoryType {
    func fetchEntries(_ callback: @escaping (Result<[Post], FetchNewPostsError>) -> ()) {
        var posts = [Post]()
        for i in (0..<20) {
            posts.append(
                Post(
                    id: i,
                    description: "Description \(i)",
                    visited: false,
                    favorite: false)
            )
        }
        callback(.success(posts))
    }
}
