//
//  AllPostsView.swift
//  WhatsNew
//
//  Created by Luis Goyes Garces on 30/07/21.
//

import SwiftUI

struct AllPostsView: View {
    @EnvironmentObject var state: AllPostsState
    private var viewModel: AllPostsViewModelProtocol?
    
    init(viewModel: AllPostsViewModelProtocol?) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            PostList(posts: state.posts)
            Spacer()
        }.onAppear() {
            viewModel?.onViewAppeared()
        }
    }
}

struct AllPostsView_Previews: PreviewProvider {
    static var previews: some View {
        let state = AllPostsState(posts: [
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
        ])
        let viewModel = AllPostsViewModel(state: state)
        AllPostsView(viewModel: viewModel)
            .environmentObject(viewModel.state)
    }
}
