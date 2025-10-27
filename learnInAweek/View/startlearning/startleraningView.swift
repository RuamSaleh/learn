import SwiftUI

struct startleraningView: View {
    @EnvironmentObject var learningModel: LearningModel
    
    @State private var textstring = "Log as Learned"
    @State private var selectedDate = Date()
    @State private var learnedDays: Set<Date> = []
    @State private var freezedDays: Set<Date> = []
    @State private var daysLearnedCount: Int = 0
    @State private var daysFreezedCount: Int = 0
    @State private var showFreezeAlert = false
    @State private var mainButtonColor: Color = .orange // default orange

    var body: some View {
        VStack(spacing: 24) {
            // Top section
            HStack {
                Text("Activity")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
                HStack(spacing: 16) {
                    Button { print("Calendar tapped!") } label: {
                        Image(systemName: "calendar")
                            .font(.system(size: 24, weight: .medium))
                    }
                    .buttonStyle(.plain)
                    
                    Button { print("Pencil tapped!") } label: {
                        Image(systemName: "pencil.and.outline")
                            .font(.system(size: 24, weight: .medium))
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)
            
            // Calendar Section
            CompactWeekCalendarView(
                learnedDays: $learnedDays,
                freezedDays: $freezedDays,
                daysLearnedCount: $daysLearnedCount,
                daysFreezedCount: $daysFreezedCount,
                selectedDate: $selectedDate
            )
            .frame(width: 365, height: 254)
            .glassEffect(.regular, in: .rect(cornerRadius: 13))
            
            // Main circular button
            Button(action: { handleLogAction(type: "learned") }) {
                Text(textstring)
                    .font(.system(size: 44, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 270, height: 270)
                    .background(
                        Circle()
                            .fill(mainButtonColor)
                            .shadow(color: mainButtonColor.opacity(0.4), radius: 15, y: 10)
                    )
                    .animation(.easeInOut(duration: 0.25), value: mainButtonColor)
            }
            
            // Secondary button (freeze)
            Button(action: { handleLogAction(type: "freezed") }) {
                HStack {
                    Image(systemName: "snowflake")
                    Text("Log as Freezed")
                        .font(.system(size: 17, weight: .medium))
                }
                .foregroundColor(.white)
                .frame(width: 182, height: 48)
                .background(
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.blue)
                        .shadow(color: .blue.opacity(0.3), radius: 8, y: 4)
                )
            }
            
            // Freeze count
            Text("\(learningModel.freezesUsed) out of \(learningModel.freezeLimit) Freezes used")
                .font(.system(size: 15))
                .foregroundColor(.white.opacity(0.8))
                .padding(.top, 8)
            
            Spacer()
        }
        .padding(.bottom, 20)
        .alert("Freeze Limit Reached", isPresented: $showFreezeAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("You’ve used all your available freezes for this \(learningModel.timeframe.lowercased()).")
        }
    }
    
    private func handleLogAction(type: String) {
        if type == "learned" {
            textstring = "Learned Today"
            mainButtonColor = .orange
            if !learnedDays.contains(selectedDate) {
                learnedDays.insert(selectedDate)
                daysLearnedCount += 1
            }
        } else if type == "freezed" {
            if learningModel.useFreeze() {
                textstring = "Day Freezed"
                mainButtonColor = .blue
                if !freezedDays.contains(selectedDate) {
                    freezedDays.insert(selectedDate)
                    daysFreezedCount += 1
                }
            } else {
                showFreezeAlert = true
            }
        }
    }
}
