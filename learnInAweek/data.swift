//
//  data.swift
//  learnInAweek
//
//  Created by ruam on 30/04/1447 AH.
//

import SwiftUI

struct data: View {
    let calendar = Calendar.current
    let currentYear = 2025

    // months for the chosen year
    var months: [Date] {
        (1...12).compactMap {
            calendar.date(from: DateComponents(year: currentYear, month: $0))
        }
    }

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 24) {
                // Header
                HStack {
                    Image(systemName: "chevron.left") // optional back arrow
                        .foregroundColor(.white.opacity(0.9))
                    Spacer()
                    Text("All activities")
                        .font(.title3.weight(.semibold))
                        .foregroundColor(.white)
                    Spacer()
                    // placeholder to balance the HStack
                    Color.clear.frame(width: 20, height: 20)
                }
                .padding(.horizontal)
                .padding(.top, 12)

                // Months
                ForEach(months, id: \.self) { month in
                    MonthView(month: month, calendar: calendar)
                }
            }
            .padding(.vertical)
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

struct MonthView: View {
    let month: Date
    let calendar: Calendar

    private var monthName: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: month)
    }

    // All dates within the month
    private var daysInMonth: [Date] {
        guard let range = calendar.range(of: .day, in: .month, for: month) else { return [] }
        return range.compactMap { day in
            calendar.date(from:
                DateComponents(year: calendar.component(.year, from: month),
                               month: calendar.component(.month, from: month),
                               day: day))
        }
    }

    // index (0..6) of first weekday for alignment (assuming sunday = 1)
    private var leadingEmptyCount: Int {
        let firstOfMonth = daysInMonth.first!
        let weekday = calendar.component(.weekday, from: firstOfMonth) // 1 = Sunday
        return (weekday - 1) // convert to 0-based, 0 means starts on Sunday
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Month title
            Text(monthName)
                .font(.headline)
                .foregroundColor(.white)
                .padding(.horizontal)

            // Weekday labels
            let weekdays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
            HStack(spacing: 10) {
                ForEach(weekdays, id: \.self) { wd in
                    Text(wd)
                        .font(.caption)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white.opacity(0.7))
                }
            }
            .padding(.horizontal)

            // Days grid (7 columns)
            let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 7)
            LazyVGrid(columns: columns, spacing: 10) {

                // Leading empty cells to align first day
                ForEach(0..<leadingEmptyCount, id: \.self) { _ in
                    Text("") // empty placeholder
                        .frame(width: 34, height: 34)
                }

                // Actual day cells
                ForEach(daysInMonth, id: \.self) { date in
                    DayCell(date: date, calendar: calendar)
                }
            }
            .padding(.horizontal)

            // Divider between months
            Divider()
                .background(Color.white.opacity(0.12))
                .padding(.horizontal)
        }
    }
}

struct DayCell: View {
    let date: Date
    let calendar: Calendar

    var body: some View {
        let day = calendar.component(.day, from: date)

        Text("\(day)")
            .font(.subheadline)
            .frame(width: 34, height: 34)
            .overlay(
                Circle()
                    .stroke(Color.white.opacity(0.12), lineWidth: 1) // simple circle stroke
            )
            .foregroundColor(.white)
    }
}

#Preview {
    data()
}
