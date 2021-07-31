//
//  BindingSegmentedControl.swift
//  WhatsNew
//
//  Created by Luis Goyes Garces on 30/07/21.
//

import SwiftUI

struct BindingSegmentedControl: View {
    @Binding var selectedOption: SegmentControlOption
    var options: [SegmentControlOption]
    var body: some View {
        Picker("", selection: $selectedOption) {
            ForEach(options, id: \.self) {
                Text($0.rawValue)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
    }
}
