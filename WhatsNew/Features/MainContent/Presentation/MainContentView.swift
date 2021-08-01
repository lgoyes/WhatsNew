//
//  MainContentView.swift
//  WhatsNew
//
//  Created by Luis Goyes Garces on 30/07/21.
//

import SwiftUI
import CoreData

struct MainContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    var body: some View {        
        let entity = AllPostsEntity(context: viewContext)
        AllPostsView(entity: entity)
            .environmentObject(entity.state)
    }
}

struct MainContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        MainContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
