//
//  ProdDBPostsRepository.swift
//  WhatsNew
//
//  Created by Luis Goyes Garces on 31/07/21.
//

import Foundation
import CoreData

class ProdDBPostsRepository: DBPostsRepositoryType {
    let context: NSManagedObjectContext?
    init(context: NSManagedObjectContext? = nil) {
        self.context = context
    }
    
    func fetchEntries(_ callback: @escaping (Result<[Post], FetchNewPostsError>) -> ()) {
        guard let context = context else {
            callback(.failure(.databaseError))
            return
        }
        
        let postsFetch : NSFetchRequest<NSFetchRequestResult> = DBPost.fetchRequest()
        do {
            let fetchedPosts = try context.fetch(postsFetch) as! [DBPost]
            callback(.success(fetchedPosts.map({ self.map(dbPost: $0) })))
        } catch {
            print(error.localizedDescription)
            callback(.failure(.databaseError))
        }
    }
    
    func map(dbPost: DBPost) -> Post {
        return Post(
            id: Int(dbPost.id),
            description: dbPost.description,
            visited: false,
            favorite: dbPost.favorite)
    }
}
