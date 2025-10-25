import SwiftUI
struct CompactWeekCalendarView: View {
    @Binding var learnedDays: Set<Date>
    @Binding var freezedDays: Set<Date>
    @Binding var daysLearnedCount: Int
    @Binding var daysFreezedCount: Int
    @Binding var selectedDate: Date

    @State private var currentWeekStart: Date = Date().startOfWeek(using: Calendar.current) ?? Date()
    @State private var showMonthPicker: Bool = false
    
    private let calendar = Calendar.current
    
    var body: some View {
        VStack(spacing: 16) {
            // Header
            HStack {
                Button(action: { withAnimation { showMonthPicker.toggle() } }) {
                    HStack(spacing: 6) {
                        Text(monthYearString(for: selectedDate))
                            .font(.headline)
                        Image(systemName: "chevron.down")
                            .font(.subheadline)
                    }
                }
                
                Spacer()
                
                HStack(spacing: 12) {
                    Button(action: { moveWeek(by: -1) }) {
                        Image(systemName: "chevron.left")
                            .font(.title2)
                    }
                    Button(action: { moveWeek(by: 1) }) {
                        Image(systemName: "chevron.right")
                            .font(.title2)
                    }
                }
            }
            .padding(.horizontal)
            
            // Week row
            HStack(spacing: 12) {
                ForEach(weekDays(startingAt: currentWeekStart), id: \.self) { date in
                    VStack(spacing: 6) {
                        Text(shortWeekdaySymbol(for: date))
                            .font(.caption2)
                            .opacity(0.8)
                        
                        Button {
                            selectedDate = date
                            currentWeekStart = selectedDate.startOfWeek(using: calendar) ?? currentWeekStart
                        } label: {
                            Text("\(calendar.component(.day, from: date))")
                                .font(.headline)
                                .frame(width: 42, height: 42)
                                .background(
                                    Circle().fill(circleColor(for: date))
                                )
                                .foregroundColor(isSameDay(date, selectedDate) ? .white : .primary)
                        }
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal)
            
            Divider().padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Learning Swift")
                    .font(.subheadline)
                    .bold()
                
                HStack(spacing: 12) {
                    HStack(spacing: 10) {
                        Image(systemName: "flame.fill")
                        VStack(alignment: .leading, spacing: 2) {
                            Text("\(daysLearnedCount)").bold()
                            Text("Days Learned").font(.caption2)
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 24).fill(Color.orange.opacity(0.2)))
                    
                    HStack(spacing: 10) {
                        Image(systemName: "cube.fill")
                        VStack(alignment: .leading, spacing: 2) {
                            Text("\(daysFreezedCount)").bold()
                            Text("Day Freezed").font(.caption2)
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 24).fill(Color.blue.opacity(0.15)))
                    
                    Spacer()
                }
            }
            .padding(.horizontal)
        }
        .padding(.vertical)
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color(.systemBackground))
                .shadow(radius: 6, y: 4)
        )
        .onAppear {
            currentWeekStart = selectedDate.startOfWeek(using: calendar) ?? Date()
        }
    }
    
    // MARK: - Helpers
    private func circleColor(for date: Date) -> Color {
        if learnedDays.contains(where: { isSameDay($0, date) }) {
            return .orange
        } else if freezedDays.contains(where: { isSameDay($0, date) }) {
            return .blue
        } else if isSameDay(date, selectedDate) {
            return Color(.secondarySystemBackground)
        } else {
            return Color(.secondarySystemBackground)
        }
    }
    
    private func moveWeek(by offset: Int) {
        guard let newStart = calendar.date(byAdding: .day, value: offset * 7, to: currentWeekStart) else { return }
        currentWeekStart = newStart
    }
    
    private func weekDays(startingAt start: Date) -> [Date] {
        (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: start) }
    }
    
    private func monthYearString(for date: Date) -> String {
        let df = DateFormatter()
        df.dateFormat = "LLLL yyyy"
        return df.string(from: date)
    }
    
    private func shortWeekdaySymbol(for date: Date) -> String {
        let symbol = calendar.shortStandaloneWeekdaySymbols[calendar.component(.weekday, from: date) - 1].uppercased()
        return String(symbol.prefix(3))
    }
    
    private func isSameDay(_ a: Date, _ b: Date) -> Bool {
        Calendar.current.isDate(a, inSameDayAs: b)
    }
}

fileprivate extension Date {
    func startOfWeek(using calendar: Calendar) -> Date? {
        let weekday = calendar.component(.weekday, from: self)
        let daysToSubtract = weekday - calendar.firstWeekday
        return calendar.date(byAdding: .day, value: -daysToSubtract, to: calendar.startOfDay(for: self))
    }
}
