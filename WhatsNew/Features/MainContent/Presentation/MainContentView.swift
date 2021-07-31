//
//  MainContentView.swift
//  WhatsNew
//
//  Created by Luis Goyes Garces on 30/07/21.
//

import SwiftUI
import CoreData

struct MainContentView: View {
    @EnvironmentObject var state: MainContentState
    private var viewModel: MainContentViewModelProtocol?
    
    init(viewModel: MainContentViewModelProtocol?) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            VStack {
                BindingSegmentedControl(
                    selectedOption: $state.selectedOption,
                    options: state.segmentControlOptions)
                
                if state.selectedOption == .all {
                    let viewModel = AllPostsViewModel()
                    AllPostsView(viewModel: viewModel)
                        .environmentObject(viewModel.state)
                } else {
                    FavoritesView()
                }
                Spacer()
                Button(NSLocalizedString(LocalizedKey.Main.deleteAll, comment: "")) {
                    viewModel?.onDeleteAllButtonTapped()
                }
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
                .background(Color.red)
            }
            .navigationBarTitle(NSLocalizedString(LocalizedKey.Main.posts, comment: ""), displayMode: .inline)
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

struct MainContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        let viewModel = MainContentViewModel()
        
        MainContentView(viewModel: viewModel)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(viewModel.state)
    }
}
