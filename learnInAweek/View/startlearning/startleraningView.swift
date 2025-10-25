import SwiftUI

struct startleraningView: View {
    @State private var textstring = "Log as Learned"
    @State private var selectedDate = Date()
    @State private var learnedDays: Set<Date> = []
    @State private var freezedDays: Set<Date> = []
    @State private var daysLearnedCount: Int = 0
    @State private var daysFreezedCount: Int = 0
    
    var body: some View {
        VStack(spacing: 24) {
            HStack {
                Text("Activity")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                HStack(spacing: 16) {
                    Button { print("Calendar tapped!") } label: {
                        Image(systemName: "calendar")
                            .font(.system(size: 26))
                    }
                    .buttonStyle(.glass)
                    
                    Button { print("Pencil tapped!") } label: {
                        Image(systemName: "pencil.and.outline")
                            .font(.system(size: 26))
                    }
                    .buttonStyle(.glass)
                }
            }
            .padding(.horizontal)
            
            ZStack {
                CompactWeekCalendarView(
                    learnedDays: $learnedDays,
                    freezedDays: $freezedDays,
                    daysLearnedCount: $daysLearnedCount,
                    daysFreezedCount: $daysFreezedCount,
                    selectedDate: $selectedDate
                )
            }
            .frame(width: 365, height: 254)
            .glassEffect(.regular, in: .rect(cornerRadius: 13))
            
            Button(action: { handleLogAction(type: "learned") }) {
                Text(textstring)
                    .frame(width: 274, height: 274)
            }
            .glassEffect(.clear.tint(.orange))
            
            Button(action: { handleLogAction(type: "freezed") }) {
                Text("Log as Freezed")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(.white)
                    .frame(width: 182, height: 48)
            }
            .glassEffect(.clear.tint(.blue).interactive())
            
            Text("out of 2 Freezes used")
        }
    }

    private func handleLogAction(type: String) {
        if type == "learned" {
            textstring = "Learned Today"
            if !learnedDays.contains(selectedDate) {
                learnedDays.insert(selectedDate)
                daysLearnedCount += 1
            }
        } else if type == "freezed" {
            textstring = "Freezed Today"
            if !freezedDays.contains(selectedDate) {
                freezedDays.insert(selectedDate)
                daysFreezedCount += 1
            }
            
        }
        
    }
}

#Preview {
    startleraningView()
}
