//
//  DevDBPostsRepository.swift
//  WhatsNew
//
//  Created by Luis Goyes Garces on 31/07/21.
//

import Foundation

class DevDBPostsRepository: DBPostsRepositoryType {
    func fetchEntries(_ callback: @escaping (Result<[Post], FetchNewPostsError>) -> ()) {
        var posts = [Post]()
        for i in (0..<3) {
            posts.append(
                Post(
                    id: i,
                    description: "Cached Description \(i)",
                    visited: false,
                    favorite: false)
            )
        }
        callback(.success(posts))
    }
}
