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
    
    var body: some View {
        NavigationView {
            VStack {
                BindingSegmentedControl(
                    selectedOption: $state.selectedOption,
                    options: state.segmentControlOptions)
                
                if state.selectedOption == .all {
                    AllPostsView()
                } else {
                    FavoritesView()
                }
                Spacer()
            }
            .navigationBarTitle("Posts", displayMode: .inline)
            .toolbar(content: {
                ToolbarItem(placement: ToolbarItemPlacement.navigationBarTrailing) {
                    Button(action: {
                        print("Help tapped!")
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
        
        MainContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(viewModel.state)
    }
}
