//
//  PostDetailView.swift
//  WhatsNew
//
//  Created by Luis Goyes Garces on 30/07/21.
//

import SwiftUI

struct PostDetailView: View {
    let onCloseDetailTapped: (Post) -> ()
    
    @EnvironmentObject private var state: PostDetailState
    
    private var entity: PostDetailEntityProtocol?
    
    init(entity: PostDetailEntityProtocol?, onCloseDetailTapped: @escaping (Post) -> ()) {
        self.entity = entity
        self.onCloseDetailTapped = onCloseDetailTapped
    }
    
    var body: some View {
        VStack {
            if let post = state.post {
                Text(post.description)
            }
        }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackButton(label: NSLocalizedString(LocalizedKey.Main.back, comment: "")) {
                if let updatedPost = self.state.post {
                    self.onCloseDetailTapped(updatedPost)
                }
            }, trailing: Button(action: {
                entity?.onFavoriteTapped()
            }) {
                if let post = self.state.post {
                    if post.favorite {
                        Image(systemName: "star.fill")
                    } else {
                        Image(systemName: "star")
                    }
                } else {
                    EmptyView()
                }
            })
            .onAppear() {
                entity?.onViewAppeared()
            }.navigationBarTitle(NSLocalizedString(LocalizedKey.Detail.post, comment: ""), displayMode: .inline)
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let entity = PostDetailEntity(post: nil, context: PersistenceController.preview.container.viewContext)
        PostDetailView(entity: entity, onCloseDetailTapped: {_ in })
            .environmentObject(entity.state)
    }
}
