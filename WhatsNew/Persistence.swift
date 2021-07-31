//
//  Persistence.swift
//  WhatsNew
//
//  Created by Luis Goyes Garces on 30/07/21.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for i in 0..<10 {
            let newUser = DBUser(context: viewContext)
            newUser.id = Int32(i)
            newUser.email = "email \(i)"
            newUser.name = "name \(i)"
            newUser.phone = "phone \(i)"
            newUser.website = "website \(i)"
            
            let newPost = DBPost(context: viewContext)
            newPost.id = Int32(i)
            newPost.body = "body \(i)"
            newPost.title = "title \(i)"
            newPost.userId = Int32( i % 3 )
            newPost.favorite = i % 2 == 0
            
            let newComment = DBComment(context: viewContext)
            newComment.id = Int32(i)
            newComment.body = "body \(i)"
            newComment.email = "email \(i)"
            newComment.name = "name \(i)"
            newComment.postId = Int32( i % 3 )
        }
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "WhatsNew")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
