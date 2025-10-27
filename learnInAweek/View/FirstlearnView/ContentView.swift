import SwiftUI

struct ContentView: View {
    @StateObject private var learningModel = LearningModel()
    @State private var selectedTimeframe: String = ""
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack {
                        Spacer().frame(height: 86)
                        
                        ZStack {
                            Circle()
                                .fill(.orange)
                                .frame(width: 109, height: 109)
                                .zIndex(0)
                            
                            Circle()
                            
                                .fill(Color.black.opacity(0.8))
                                .frame(width: 109, height: 109)
                                .glassEffect(.clear)
                                .zIndex(1)
                            
                            Image(systemName: "flame.fill")
                                .symbolRenderingMode(.hierarchical)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundStyle(.orange)
                                .zIndex(2)
                        }
                        .frame(width: 109, height: 109)
                        
                        Spacer().frame(height: 47)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Hello Learner")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                            
                            Text("This app will help you learn everyday!")
                                    .font(.body)
                                    .foregroundStyle(.gray)
                                    .fontWeight(.semibold)
                            }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 17)
                        
                        Spacer().frame(height: 31)
                        
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
                            Text("I want to learn it in a ")
                                .font(.system(size: 22))
                                .foregroundColor(.white)
                            
                            HStack(spacing: 8) {
                                TimeframeButton(title: "Week", selectedTimeframe: $learningModel.timeframe)
                                TimeframeButton(title: "Month", selectedTimeframe: $learningModel.timeframe)
                                TimeframeButton(title: "Year", selectedTimeframe: $learningModel.timeframe)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 17)
                        
                        Spacer().frame(height: 223)
                        
                        NavigationLink(destination: startleraningView().environmentObject(learningModel)) {
                            Text("Start learning")
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .frame(width: 182, height: 48)
                        }
                        .glassEffect(.clear.tint(.orange))
                        .glassEffect(.regular.tint(.black))
                        .shadow(color: .white, radius: -1, x: 0.2, y: 0.2)
                        
                        Spacer().frame(height: 56)
                    }
                }
                .scrollDisabled(true)
                .ignoresSafeArea()
            }
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    
    ContentView()
}
