//
//  PostDetailView.swift
//  WhatsNew
//
//  Created by Luis Goyes Garces on 30/07/21.
//

import SwiftUI

struct PostDetailView: View {
    let onCloseDetailTapped: () -> ()
    var post: Post!
    
    var body: some View {
        Text("Hello, World!")
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackButton(label: NSLocalizedString(LocalizedKey.Main.back, comment: "")) {
                self.onCloseDetailTapped()
            })
            .onAppear() {
                
            }.navigationBarTitle(NSLocalizedString(LocalizedKey.Detail.post, comment: ""), displayMode: .inline)
    }
}

struct PostDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView(onCloseDetailTapped: {}, post: nil)
    }
}
