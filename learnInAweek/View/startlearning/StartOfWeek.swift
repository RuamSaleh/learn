// Date+StartOfWeek.swift
import Foundation

extension Date {
    // Returns the start of the week for the given calendar, respecting its firstWeekday and locale.
    func startOfWeek(using calendar: Calendar = .current) -> Date? {
        // Use dateInterval(of:for:) to get the week interval containing this date
        if let weekInterval = calendar.dateInterval(of: .weekOfYear, for: self) {
            return weekInterval.start
        }
        return nil
    }
}
