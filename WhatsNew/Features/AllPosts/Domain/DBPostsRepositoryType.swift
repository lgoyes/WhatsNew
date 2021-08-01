//
//  DBPostsRepositoryType.swift
//  WhatsNew
//
//  Created by Luis Goyes Garces on 31/07/21.
//

import Foundation

protocol DBPostsRepositoryType: AnyObject {
    func fetchEntries(_ callback: @escaping (Result<[Post], FetchNewPostsError>) -> ())
    func storePostsWithoutOverride(items: [Post])
}
