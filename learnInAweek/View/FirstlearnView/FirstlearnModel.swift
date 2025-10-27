////
////  FirstlearnModel.swift
////  learnInAweek

import SwiftUI

struct TimeframeButton: View {
    let title: String
    @Binding var selectedTimeframe: String

    var body: some View {
        Button(action: { selectedTimeframe = title }) {
            Text(title)
                .frame(width: 97, height: 48)
                .fontWeight(.bold)
        }
        .buttonStyle(.glass(.regular.tint(selectedTimeframe == title ? .orange : .clear)))
        .glassEffect(.regular.tint(.black))
        .shadow(color: .white, radius: -0.2, x: 0.2, y: 0.2)
    }
}
