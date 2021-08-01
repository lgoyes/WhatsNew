//
//  AllPostsView.swift
//  WhatsNew
//
//  Created by Luis Goyes Garces on 30/07/21.
//

import SwiftUI

struct AllPostsView: View {
    @EnvironmentObject var state: AllPostsState
    private var entity: AllPostsEntityProtocol?
    
    init(entity: AllPostsEntityProtocol?) {
        self.entity = entity
    }
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    if !state.loadingRequest {
                        BindingSegmentedControl(
                            selectedOption: $state.selectedOption,
                            options: state.segmentControlOptions)
                        
                        let visiblePosts = state.selectedOption == .all ? state.posts : state.posts.filter({ $0.favorite })
                        PostList(posts: visiblePosts) { (post) in
                            entity?.onRowSelected(post: post)
                        }
                        
                        if state.posts.count > 0 {
                            Button(NSLocalizedString(LocalizedKey.Main.deleteAll, comment: "")) {
                                entity?.onDeleteAllButtonTapped()
                            }
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .center)
                            .background(Color.red)
                        }
                    } else {
                        Spacer()
                        HStack {
                            Spacer()
                            VStack {
                                Text(NSLocalizedString(LocalizedKey.Main.loading, comment: ""))
                                ActivityIndicator(isAnimating: .constant(true), style: .large)
                            }
                                .frame(width: geometry.size.width / 2,
                                        height: geometry.size.height / 5)
                                .background(Color.secondary.colorInvert())
                                .foregroundColor(Color.primary)
                                .cornerRadius(20)
                            Spacer()
                        }
                        Spacer()
                    }
                }.onAppear() {
                    entity?.onViewAppeared()
                }.navigationBarTitle(NSLocalizedString(LocalizedKey.Main.posts, comment: ""), displayMode: .inline)
                .toolbar(content: {
                    ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                        if !state.loadingRequest {
                            Button(action: {
                                entity?.onRefreshButtonTapped()
                            }) {
                                Image(systemName: "gobackward")
                            }
                        }
                    }
                })
                .alert(isPresented: $state.presentingError, content: {
                    Alert(
                        title: Text(NSLocalizedString(LocalizedKey.Error.title, comment: "")),
                        message: Text(state.errorMessage ?? ""),
                        dismissButton: .default(Text(NSLocalizedString(LocalizedKey.Error.action, comment: "")), action: {
                            entity?.onErrorDialogAction()
                        })
                    )
                })
            }
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct AllPostsView_Previews: PreviewProvider {
    static var previews: some View {
        let state = AllPostsState(
            segmentControlOptions: SegmentControlOption.allCases,
            selectedOption: SegmentControlOption.all,
            posts: [
                Post(id: 1, description: "hola", visited: true, favorite: true),
                Post(id: 2, description: "hola", visited: false, favorite: false),
                Post(id: 3, description: "hola", visited: true, favorite: true),
                Post(id: 4, description: "hola", visited: true, favorite: false),
                Post(id: 5, description: "hola", visited: true, favorite: true),
                Post(id: 6, description: "hola", visited: false, favorite: false),
                Post(id: 7, description: "hola", visited: true, favorite: true),
                Post(id: 8, description: "hola", visited: false, favorite: false),
                Post(id: 9, description: "hola", visited: true, favorite: true),
                Post(id: 10, description: "hola", visited: true, favorite: false),
                Post(id: 11, description: "hola", visited: true, favorite: true),
            ],
            errorMessage: nil,
            presentingError: false,
            loadingRequest: false
        )
        let entity = AllPostsEntity(state: state)
        AllPostsView(entity: entity)
            .environmentObject(entity.state)
    }
}
