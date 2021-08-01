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
        } catch let error as NSError {
            print(error)
            callback(.failure(.databaseError))
        }
    }
    
    func map(dbPost: DBPost) -> Post {
        return Post(
            id: Int(dbPost.id),
            description: dbPost.title ?? "",
            visited: dbPost.visited,
            favorite: dbPost.favorite,
            fetchDate: dbPost.fetchDate ?? Date())
    }
    
    func storePostsWithoutOverride(items: [Post]) {
        guard let context = context else {
            return
        }
        
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = DBPost.fetchRequest()
        items.forEach { domainPost in
            let id = Int32(domainPost.id)
            fetchRequest.predicate = NSPredicate(format: "id = %i", id)
            if let fetchResult = try? context.fetch(fetchRequest) as? [DBPost],
               fetchResult.count == 0 {
                let dbPost = DBPost(context: context)
                dbPost.id = Int32(domainPost.id)
                dbPost.title = domainPost.description
                dbPost.visited = domainPost.visited
                dbPost.favorite = domainPost.favorite
            }
        }
        
        do {
            try context.save()
        } catch let error as NSError {
            assertionFailure(error.localizedDescription)
        }
    }
    func clearCache() {
        guard let context = context else {
            return
        }
        
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = DBPost.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
        } catch let error as NSError {
            print(error)
        }
    }
    func getPostById(postId: Int, callback: @escaping (Post?) -> ()) {
        guard let context = context else {
            callback(nil)
            return
        }
        
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = DBPost.fetchRequest()
        
        let id = Int32(postId)
        fetchRequest.predicate = NSPredicate(format: "id = %i", id)
        if let fetchResult = try? context.fetch(fetchRequest) as? [DBPost],
           let firstDBPost = fetchResult.first {
            let post = map(dbPost: firstDBPost)
            callback(post)
        } else {
            callback(nil)
        }
    }
    func updatePost(postId: Int, post: Post, callback: @escaping (Post?) -> ()) {
        guard let context = context else {
            callback(nil)
            return
        }
        
        let fetchRequest : NSFetchRequest<NSFetchRequestResult> = DBPost.fetchRequest()
        
        let id = Int32(postId)
        fetchRequest.predicate = NSPredicate(format: "id = %i", id)
        if let fetchResult = try? context.fetch(fetchRequest) as? [DBPost],
           let firstDBPost = fetchResult.first {
            firstDBPost.title = post.description
            firstDBPost.visited = post.visited
            firstDBPost.favorite = post.favorite
            
            do {
                try context.save()
                
                let post = map(dbPost: firstDBPost)
                callback(post)
            } catch let error as NSError {
                assertionFailure(error.localizedDescription)
            }
        } else {
            callback(nil)
        }
    }
}
