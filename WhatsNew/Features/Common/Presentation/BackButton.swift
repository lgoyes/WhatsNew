//
//  BackButton.swift
//  WhatsNew
//
//  Created by Luis Goyes Garces on 1/08/21.
//

import SwiftUI

struct BackButton: View {
    let label: String
    let closure: () -> ()

    var body: some View {
        Button(action: { self.closure() }) {
            HStack {
                Image(systemName: "chevron.left")
                Text(label)
            }
        }
    }
}
