import SwiftUI

struct ContentView: View {
    @State private var selectedTimeframe: String = ""

    var body: some View {
        NavigationStack {
            VStack {
                Spacer().frame(height: 86)

                ZStack {
                    Circle()
                        .fill(Color.orange.opacity(0.3))
                        .fill(Color.black.opacity(0.7))
                        .glassEffect()
                    Circle()
                        .stroke(.white.opacity(0.4), lineWidth: 1)
                        .glassEffect()
                    Image(systemName: "flame.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 36, height: 36)
                        .foregroundStyle(Color.orange)
                }
                .frame(width: 109, height: 109)

                Spacer().frame(height: 47)

                VStack(alignment: .leading, spacing: 4) {
                    Text("Hello Learner")
                        .font(.largeTitle)
                        .fontWeight(.bold)

                    Text("This app will help you learn everyday!")
                        .foregroundColor(.white.opacity(0.5))
                        .font(.system(size: 17))
                }

                Spacer().frame(height: 31)

                VStack(alignment: .leading, spacing: 4) {
                    Text("I want to learn")
                        .font(.system(size: 22))
                        .foregroundColor(.white)
                    TextField("Swift", text: .constant(""))
                        .textFieldStyle(.plain)
                    Divider()
                }

                Spacer().frame(height: 24)

                VStack(alignment: .leading, spacing: 16) {
                    Text("I want to learn it in a")
                        .font(.system(size: 22))
                    HStack(spacing: 8) {
                        TimeframeButton(title: "Week", selectedTimeframe: $selectedTimeframe)
                        TimeframeButton(title: "Month", selectedTimeframe: $selectedTimeframe)
                        TimeframeButton(title: "Year", selectedTimeframe: $selectedTimeframe)
                    }
                }

                Spacer().frame(height: 223)

                // ✅ Navigation to startleraningView
                NavigationLink(destination: startleraningView()) {
                    Text("Start Learning")
                        .font(.system(size: 17, weight: .medium))
                        .foregroundColor(.white)
                        .frame(width: 182, height: 48)
                        .glassEffect(.clear.tint(.orange).interactive())
                }
            }
        }
    }
}

struct TimeframeButton: View {
    let title: String
    @Binding var selectedTimeframe: String
    var body: some View {
        Button(action: { selectedTimeframe = title }) {
            Text(title)
                .font(.system(size: 17))
                .padding(.vertical, 16)
                .padding(.horizontal, 21)
                .background(selectedTimeframe == title ? Color.orange : Color.gray.opacity(0.1))
                .foregroundColor(selectedTimeframe == title ? .white : .primary)
                .cornerRadius(30)
        }
        .buttonStyle(.glass)
    }
}

#Preview {
    ContentView()
}
