//
//  PostDetailView.swift
//  WhatsNew
//
//  Created by Luis Goyes Garces on 30/07/21.
//

import SwiftUI

struct PostDetailView: View {
    var postId: Int
    var userId: Int
    
    var body: some View {
        Text("Hello, World!")
            .onAppear() {
                
            }
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView(postId: 5, userId: 5)
    }
}
