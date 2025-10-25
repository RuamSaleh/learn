//
//  CompactWeekCalendarView.swift
//  learnInAweek
//
//  Created by ruam on 02/05/1447 AH.
//
//
//import SwiftUI
//
//struct CompactWeekCalendarView: View {
//    // The currently selected date
//    @State private var selectedDate: Date = Date()
//    // The start-of-week currently being shown (Sunday..Saturday)
//    @State private var currentWeekStart: Date = Date().startOfWeek(using: Calendar.current) ?? Date()
//    // Toggle to show the month (graphical) picker
//    @State private var showMonthPicker: Bool = false
//    
//    private let calendar = Calendar.current
//    
//    var body: some View {
//        VStack(spacing: 16) {
//            // Header: month label + arrows
//            HStack {
//                // Month label (tap to open month / date picker)
//                Button(action: { withAnimation { showMonthPicker.toggle() } }) {
//                    HStack(spacing: 6) {
//                        Text(monthYearString(for: selectedDate))
//                            .font(.headline)
//                        Image(systemName: "chevron.down")
//                            .font(.subheadline)
//                    }
//                }
//                
//                Spacer()
//                
//                // arrows: previous week / next week
//                HStack(spacing: 12) {
//                    Button(action: { moveWeek(by: -1) }) {
//                        Image(systemName: "chevron.left")
//                            .font(.title2)
//                    }
//                    Button(action: { moveWeek(by: 1) }) {
//                        Image(systemName: "chevron.right")
//                            .font(.title2)
//                    }
//                }
//            }
//            .padding(.horizontal)
//            
//            // Week days row
//            HStack(spacing: 12) {
//                ForEach(weekDays(startingAt: currentWeekStart), id: \.self) { date in
//                    VStack(spacing: 6) {
//                        Text(shortWeekdaySymbol(for: date)) // SUN MON ...
//                            .font(.caption2)
//                            .opacity(0.8)
//                        
//                        // day circle
//                        Button(action: {
//                            selectedDate = date
//                            currentWeekStart = selectedDate.startOfWeek(using: calendar) ?? currentWeekStart
//                        }) {
//                            Text("\(calendar.component(.day, from: date))")
//                                .font(.headline)
//                                .frame(width: 42, height: 42)
//                                .background(
//                                    Circle()
//                                        .fill(isSameDay(date, selectedDate) ? Color.orange : Color(.secondarySystemBackground))
//                                )
//                                .foregroundColor(isSameDay(date, selectedDate) ? .white : .primary)
//                        }
//                    }
//                    .frame(maxWidth: .infinity)
//                }
//            }
//            .padding(.horizontal)
//            
//            // Divider
//            Divider()
//                .padding(.horizontal)
//            
//            // Learning label + pill stats row (simple example)
//            VStack(alignment: .leading, spacing: 12) {
//                Text("Learning Swift")
//                    .font(.subheadline)
//                    .bold()
//                
//                HStack(spacing: 12) {
//                    // Pill 1
//                    HStack(spacing: 10) {
//                        Image(systemName: "flame.fill")
//                        VStack(alignment: .leading, spacing: 2) {
//                            Text("3").bold()
//                            Text("Days Learned").font(.caption2)
//                        }
//                    }
//                    .padding()
//                    .background(RoundedRectangle(cornerRadius: 24).fill(Color.orange.opacity(0.2)))
//                    
//                    // Pill 2
//                    HStack(spacing: 10) {
//                        Image(systemName: "cube.fill")
//                        VStack(alignment: .leading, spacing: 2) {
//                            Text("1").bold()
//                            Text("Day Freezed").font(.caption2)
//                        }
//                    }
//                    .padding()
//                    .background(RoundedRectangle(cornerRadius: 24).fill(Color.blue.opacity(0.15)))
//                    
//                    Spacer()
//                }
//            }
//            .padding(.horizontal)
//        }
//        .padding(.vertical)
//        .background(
//            RoundedRectangle(cornerRadius: 14)
//                .fill(Color(.systemBackground))
//                .shadow(radius: 6, y: 4)
//        )
//        .overlay(
//            // Month / date picker overlay
//            Group {
//                if showMonthPicker {
//                    Color.black.opacity(0.3)
//                        .ignoresSafeArea()
//                        .onTapGesture { withAnimation { showMonthPicker = false } }
//                    
//                    // Picker card
//                    VStack {
//                        DatePicker(
//                            "",
//                            selection: $selectedDate,
//                            // *** KEY CHANGE 1: Display only month and year components ***
//                            displayedComponents: [.date]
//                        )
//                        // *** KEY CHANGE 2: Use the .wheel date picker style ***
//                        .datePickerStyle(.wheel)
//                        .labelsHidden()
//                        // Changed the frame to make it smaller for the wheel style
//                        .frame(maxWidth: 300, maxHeight: 180)
//                        .cornerRadius(12)
//                        
//                        Button("Done") {
//                            // When user picks a date, sync the week view to that date
//                            currentWeekStart = selectedDate.startOfWeek(using: calendar) ?? currentWeekStart
//                            withAnimation { showMonthPicker = false }
//                        }
//                        .padding(.top, 8)
//                    }
//                    .padding()
//                    .background(.regularMaterial)
//                    .cornerRadius(14)
//                    .shadow(radius: 12)
//                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
//                }
//            }
//        )
//        .onAppear {
//            // Ensure the week starts from today on appear
//            currentWeekStart = selectedDate.startOfWeek(using: calendar) ?? Date()
//        }
//    }
//    
//    // MARK: - helpers
//    
//    private func moveWeek(by offset: Int) {
//        guard let newStart = calendar.date(byAdding: .day, value: offset * 7, to: currentWeekStart) else { return }
//        currentWeekStart = newStart
//    }
//    
//    private func weekDays(startingAt start: Date) -> [Date] {
//        // returns 7 dates starting at `start`
//        (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: start) }
//    }
//    
//    private func monthYearString(for date: Date) -> String {
//        let df = DateFormatter()
//        df.dateFormat = "LLLL yyyy" // October 2025
//        return df.string(from: date)
//    }
//    
//    private func shortWeekdaySymbol(for date: Date) -> String {
//        let symbol = calendar.shortStandaloneWeekdaySymbols[calendar.component(.weekday, from: date) - 1].uppercased()
//        // you can return abbreviated or single-letter if you'd like: [.short|.narrow]
//        return String(symbol.prefix(3)) // e.g., SUN, MON
//    }
//    
//    private func isSameDay(_ a: Date, _ b: Date) -> Bool {
//        calendar.isDate(a, inSameDayAs: b)
//    }
//}
//
////
//// MARK: - Date extension to get start of week (Sunday-based by default)
//fileprivate extension Date {
//    func startOfWeek(using calendar: Calendar) -> Date? {
//        // Attempt to find the start of week for the calendar's setting
//        let weekday = calendar.component(.weekday, from: self)
//        // weekday = 1 for Sunday in Gregorian by default (in many locales)
//        let daysToSubtract = weekday - calendar.firstWeekday
//        return calendar.date(byAdding: .day, value: -daysToSubtract, to: calendar.startOfDay(for: self))
//    }
//}
//
////
//// MARK: - Preview
//struct CompactWeekCalendarView_Previews: PreviewProvider {
//    static var previews: some View {
//        CompactWeekCalendarView()
//            .padding()
//            .previewLayout(.sizeThatFits)
//    }
//}
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
