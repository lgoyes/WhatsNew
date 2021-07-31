//
//  PostList.swift
//  WhatsNew
//
//  Created by Luis Goyes Garces on 31/07/21.
//

import SwiftUI

struct PostRow: View {
    var visited: Bool
    var favorite: Bool
    var description: String
    var postId: Int
    
    var body: some View {
        HStack{
            if favorite {
                Image(systemName: "star.fill")
                    .foregroundColor(Color.yellow)
            } else if visited {
                Image(systemName: "circle.fill")
                    .foregroundColor(Color.blue)
            } else {
                Image(systemName: "circle")
                    .foregroundColor(Color.blue)
            }
            Text(description)
            Spacer()
            Image(systemName: "chevron.right")
        }
    }
}

struct PostList: View {
    var posts: [Post]
    
    var body: some View {
        List(posts) { post in
            PostRow(
                visited: post.visited,
                favorite: post.favorite,
                description: post.description,
                postId: post.id)
        }
    }
}
