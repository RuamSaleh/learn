import SwiftUI

struct goal: View {
    @StateObject private var learningModel = LearningModel()
    @State private var selectedTimeframe: String = ""
    @State private var showPopup = false
    @State private var navigateToStartLearning = false
    
    var body: some View {
        ZStack {
            VStack {
                ZStack {
                    Text("Learning Goal")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    if !learningModel.timeframe.isEmpty {
                        Button {
                            showPopup = true
                        } label: {
                            Image(systemName: "checkmark")
                                .font(.system(size: 17, weight: .medium))
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.orange)
                                .clipShape(Circle())
                        }
                        .glassEffect()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .offset(x: -13)
                    }
                }
                .padding(.horizontal, 17)
                
                Spacer().frame(height: 32)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("I want to learn")
                        .font(.system(size: 22))
                        .foregroundColor(.white)
                    
                    TextField("Swift", text: $learningModel.topic)
                        .font(.system(size: 17))
                        .accentColor(.orange)
                        .frame(maxWidth: .infinity, maxHeight: 48)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 14)
                    
                    Divider()
                        .frame(width: 361, height: 1)
                        .background(Color.white.opacity(0.5))
                }
                .padding(.horizontal, 17)
                
                Spacer().frame(height: 24)
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("I want to learn it in a")
                        .font(.system(size: 22))
                    
                    HStack(spacing: 8) {
                        TimeframeButton(title: "Week", selectedTimeframe: $learningModel.timeframe)
                        TimeframeButton(title: "Month", selectedTimeframe: $learningModel.timeframe)
                        TimeframeButton(title: "Year", selectedTimeframe: $learningModel.timeframe)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 17)
                
                Spacer()
            }
            
            if showPopup {
                Color.black.opacity(0.6)
                    .ignoresSafeArea()
                    .onTapGesture { } // disable background taps
                
                VStack(spacing: 20) {
                    Text("Update Learning goal")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.white)
                    
                    Text("If you update now, your streak will start over.")
                        .font(.system(size: 16))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.horizontal, 24)
                    
                    HStack(spacing: 12) {
                        Button(action: {
                            showPopup = false
                        }) {
                            Text("Dismiss")
                                .font(.system(size: 17, weight: .semibold))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.gray.opacity(0.4))
                                .cornerRadius(24)
                        }
                        
                        Button(action: {
                            showPopup = false
                            navigateToStartLearning = true
                        }) {
                            Text("Update")
                                .font(.system(size: 17, weight: .semibold))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.orange)
                                .cornerRadius(24)
                                .foregroundColor(.white)
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .padding(.vertical, 30)
                .frame(width: 320)
                .background(Color.black.opacity(0.9))
                .cornerRadius(28)
                .shadow(radius: 20)
                .transition(.scale.combined(with: .opacity))
                .animation(.spring(), value: showPopup)
            }
        }
        .fullScreenCover(isPresented: $navigateToStartLearning) {
            startleraningView()
                .environmentObject(learningModel)
        }

    }
}

#Preview {
    goal()
}
