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
        NavigationView {
            VStack {
                BindingSegmentedControl(
                    selectedOption: $state.selectedOption,
                    options: state.segmentControlOptions)
                
                PostList(posts: state.posts)
                
                Spacer()
                
                Button(NSLocalizedString(LocalizedKey.Main.deleteAll, comment: "")) {
                    viewModel?.onDeleteAllButtonTapped()
                }
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
                .background(Color.red)
            }.onAppear() {
                viewModel?.onViewAppeared()
            }.navigationBarTitle(NSLocalizedString(LocalizedKey.Main.posts, comment: ""), displayMode: .inline)
            .toolbar(content: {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    Button(action: {
                        viewModel?.onRefreshButtonTapped()
                    }) {
                        Image(systemName: "gobackward")
                    }
                }
            })
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
            ])
        let viewModel = AllPostsViewModel(state: state)
        AllPostsView(viewModel: viewModel)
            .environmentObject(viewModel.state)
    }
}
