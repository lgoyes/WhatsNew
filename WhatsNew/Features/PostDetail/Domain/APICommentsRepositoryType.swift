//
//  APICommentsRepositoryType.swift
//  WhatsNew
//
//  Created by Luis Goyes Garces on 1/08/21.
//

import Foundation

protocol APICommentsRepositoryType: AnyObject {
    func fetchComments(postId: Int, _ callback: @escaping (Result<[Comment], FetchCommentsError>) -> ())
}
