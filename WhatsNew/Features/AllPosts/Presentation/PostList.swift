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
                Image(systemName: "circle")
                    .foregroundColor(Color.blue)
            } else {
                Image(systemName: "circle.fill")
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
    var onRowSelected: (Post) -> ()
    
    var body: some View {
        if posts.count > 0 {
            List(posts.sorted(by: {
                ($0.favorite && !$1.favorite) ||
                    (!$0.favorite && !$1.favorite) && ((!$0.visited && $1.visited) ||
                                                        (((!$0.visited && !$1.visited) || ($0.visited && $1.visited)) && $0.fetchDate > $1.fetchDate))
            })) { post in
                PostRow(
                    visited: post.visited,
                    favorite: post.favorite,
                    description: post.description,
                    postId: post.id)
                    .onTapGesture {
                        onRowSelected(post)
                    }
            }
        } else {
            Spacer()
            Text(NSLocalizedString(LocalizedKey.Main.emptyPosts, comment: ""))
        }
        Spacer()
    }
}
