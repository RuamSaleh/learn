//
//  goal.swift
//  learnInAweek
//
//  Created by ruam on 04/05/1447 AH.
//
import SwiftUI
struct goal: View {
    @StateObject private var learningModel = LearningModel()
    @State private var selectedTimeframe: String = ""
    var body: some View {
        VStack {
            HStack {
                Text("Learning Goal")
                    .font(.title)
            }
            Spacer().frame(height: 32)
            
            
            VStack(alignment: .leading, spacing: 4) {
                Text("I want to learn")
                    .font(.system(size: 22))
                    .foregroundColor(.white)
                TextField("Swift", text: $learningModel.topic) 
                    .textFieldStyle(.plain)
                Divider()
            }
            
            Spacer().frame(height: 24)
            
            VStack(alignment: .leading, spacing: 16) {
                Text("I want to learn it in a")
                    .font(.system(size: 22))
                HStack(spacing: 8) {
                    TimeframeButton(title: "Week", selectedTimeframe: $learningModel.timeframe)
                    TimeframeButton(title: "Month", selectedTimeframe: $learningModel.timeframe)
                    TimeframeButton(title: "Year", selectedTimeframe: $learningModel.timeframe)
                }
            }
            
            Spacer().frame(height: 514)
        }}}
#Preview {
    goal()
}
