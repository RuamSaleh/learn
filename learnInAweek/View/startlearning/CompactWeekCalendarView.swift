import SwiftUI

struct CompactWeekCalendarView: View {
    @Binding var learnedDays: Set<Date>
    @Binding var freezedDays: Set<Date>
    @Binding var daysLearnedCount: Int
    @Binding var daysFreezedCount: Int
    @Binding var selectedDate: Date
    var disableDaySelection: Bool = false
    
    
    @State private var currentWeekStart: Date = Date().startOfWeek(using: Calendar.current) ?? Date()
    @State private var showMonthPicker: Bool = false
    @State private var selectedMonth: Int = Calendar.current.component(.month, from: Date())
    @State private var selectedYear: Int = Calendar.current.component(.year, from: Date())
    

    private let calendar = Calendar.current // the Calendar start from today
    
    private var allFreezeUsed: Bool {
        return daysFreezedCount >= 8 // the user can not freeze more then 8 days
    }
    
    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Button(action: { withAnimation(.spring()) { showMonthPicker.toggle() } }) {
                    HStack(spacing: 6) {
                        Text(monthYearString(for: selectedDate))
                            .font(.headline)
                        Image(systemName: showMonthPicker ? "chevron.up" : "chevron.down")
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
            
            
            
            
            
            // for the month and year Picker
            .overlay(
                Group {
                    if showMonthPicker {
                        Color.black.opacity(0.3)
                            .ignoresSafeArea()
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    showMonthPicker = false
                                    updateSelectedDate()
                                }
                            }
                            .transition(.opacity)
                        
                        VStack(spacing: 12) {
                            HStack(spacing: 20) {
                                Picker("Year", selection: $selectedYear) {
                                    ForEach((2020...2035), id: \.self) { year in
                                        Text("\(year)").tag(year)
                                    }
                                }
                                .pickerStyle(.wheel)
                                .frame(width: 100, height: 160)
                                
                                Picker("Month", selection: $selectedMonth) {
                                    ForEach(1...12, id: \.self) { month in
                                        Text(DateFormatter().monthSymbols[month - 1]).tag(month)
                                    }
                                }
                                .pickerStyle(.wheel)
                                .frame(width: 140, height: 160)
                            }
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color(.systemBackground))
                                .shadow(radius: 10)
                        )
                        .frame(maxWidth: 320)
                        .transition(.scale.combined(with: .opacity))
                    }
                }
            )
            
            
            
            
            // the display of the days
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
                                .background(Circle().fill(circleColor(for: date)))
                                .foregroundColor(isSameDay(date, selectedDate) ? .white : .primary)
                        }
                       
                        .disabled(isDayLogged(date) || allFreezeUsed)
                        .opacity((isDayLogged(date) || allFreezeUsed) ? 0.4 : 1.0)
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
                            Text("Days Freezed").font(.caption2)
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
    // when we start new month
    private func updateSelectedDate() {
        var components = DateComponents()
        components.year = selectedYear
        components.month = selectedMonth
        components.day = 1
        if let newDate = calendar.date(from: components) {
            selectedDate = newDate
            currentWeekStart = newDate.startOfWeek(using: calendar) ?? currentWeekStart
        }
    }
    
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
        calendar.isDate(a, inSameDayAs: b)
    }
    
    private func isDayLogged(_ date: Date) -> Bool {
        learnedDays.contains(where: { isSameDay($0, date) }) ||
        freezedDays.contains(where: { isSameDay($0, date) })
    }
}
