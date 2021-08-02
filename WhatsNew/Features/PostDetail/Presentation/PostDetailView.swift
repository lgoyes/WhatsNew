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
        ZStack {
            if let post = state.post {
                GeometryReader { geometry in
                    VStack {
                        Text(NSLocalizedString(LocalizedKey.Detail.description, comment: ""))
                            .font(.system(size: 20, weight: .semibold, design: .default))
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                        Text(post.body)
                        
                        Spacer().frame(height: 25)
                        
                        Text(NSLocalizedString(LocalizedKey.Detail.user, comment: ""))
                            .font(.system(size: 20, weight: .semibold, design: .default))
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                        
                        Spacer().frame(height: 25)
                        
                        Text(NSLocalizedString(LocalizedKey.Detail.comments, comment: ""))
                            .font(.system(size: 20, weight: .semibold, design: .default))
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                            .foregroundColor(Color.white)
                            .background(Color.gray)
                    }.frame(maxWidth: .infinity)
                }.alert(isPresented: $state.presentingError, content: {
                    Alert(
                        title: Text(NSLocalizedString(LocalizedKey.Error.title, comment: "")),
                        message: Text(state.errorMessage ?? ""),
                        dismissButton: .default(Text(NSLocalizedString(LocalizedKey.Error.action, comment: "")), action: {
                            entity?.onErrorDialogAction()
                        })
                    )
                })
            }
        }
        .frame(maxWidth: .infinity)
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
