//
//  APIPostRepositoryType.swift
//  WhatsNew
//
//  Created by Luis Goyes Garces on 31/07/21.
//

import Foundation

protocol APIPostsRepositoryType: AnyObject {
    func fetchEntries(_ callback: @escaping (Result<[Post], FetchNewPostsError>) -> ())
}
