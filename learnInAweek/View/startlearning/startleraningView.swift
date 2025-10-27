import SwiftUI

struct startleraningView: View {

    @EnvironmentObject var learningModel: LearningModel
    @State private var selectedDate = Date()
    @State private var textstring = "Log as Learned"
    @State private var mainButtonColor: Color = .orange
    @State private var hasLoggedToday = false
    @State private var navigateToGoal = false
    @State private var showFreezeAlert = false


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
                            .font(.system(size: 24, weight: .medium))
                    }
                    .buttonStyle(.glass)
                    
                    Button {
                        navigateToGoal = true
                    } label: {
                        Image(systemName: "pencil.and.outline")
                            .font(.system(size: 24, weight: .medium))
                    }
                    .buttonStyle(.glass)
                }
            }
            .padding(.horizontal)
            .padding(.top, 10)
            CompactWeekCalendarView(
                learnedDays: $learningModel.learnedDays,
                freezedDays: $learningModel.freezedDays,
                daysLearnedCount: $learningModel.daysLearnedCount,
                daysFreezedCount: $learningModel.daysFreezedCount,
                selectedDate: $selectedDate,
                disableDaySelection: true
            )

            .frame(width: 365, height: 254)
            .glassEffect(.regular, in: .rect(cornerRadius: 13))
            
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
            .disabled(hasLoggedToday)
            
            Button(action: { handleLogAction(type: "freezed") }) {
                HStack {
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
            .disabled(hasLoggedToday)
            
            Text("\(learningModel.freezesUsed) out of \(learningModel.freezeLimit) Freezes used")
                .font(.system(size: 15))
                .foregroundColor(.white.opacity(0.8))
                .padding(.top, 8)
            
            Spacer()
        }
        .padding(.bottom, 20)
        .fullScreenCover(isPresented: $navigateToGoal) {
            goal()
                .environmentObject(learningModel)
        }
        .navigationBarHidden(true)
    }
    
    private func handleLogAction(type: String) {
        selectedDate = Date()
        
        if type == "learned" {
            learningModel.logLearnedDay(selectedDate)
            textstring = "Learned Today"
            mainButtonColor = .orange
            hasLoggedToday = true
        } else if type == "freezed" {
            if learningModel.logFreezedDay(selectedDate) {
                textstring = "Day Freezed"
                mainButtonColor = .blue
                hasLoggedToday = true
            } else {
                showFreezeAlert = true
            }
        }
    }

    
    
    
}

