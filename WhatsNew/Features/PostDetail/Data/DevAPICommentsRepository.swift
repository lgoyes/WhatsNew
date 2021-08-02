//
//  DevAPICommentsRepository.swift
//  WhatsNew
//
//  Created by Luis Goyes Garces on 1/08/21.
//

import Foundation

class DevAPICommentsRepository: APICommentsRepositoryType {
    func fetchComments(postId: Int, _ callback: @escaping (Result<[Comment], FetchCommentsError>) -> ()) {
        let comment = Comment(id: 1, body: "this is a comment")
        callback(.success([comment]))
    }
}
