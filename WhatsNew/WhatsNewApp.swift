//
//  WhatsNewApp.swift
//  WhatsNew
//
//  Created by Luis Goyes Garces on 30/07/21.
//

import SwiftUI

@main
struct WhatsNewApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            let viewModel = MainContentViewModel()
            MainContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(viewModel.state)
        }
    }
}
