//
//  LearningModel.swift
//  learnInAweek
//
//  Created by ruam on 04/05/1447 AH.
//


import SwiftUI
import Combine

class LearningModel: ObservableObject {
    @Published var topic: String = ""
    @Published var timeframe: String = ""
    @Published var freezesUsed: Int = 0
    @Published var learnedDays: Set<Date> = []
    @Published var freezedDays: Set<Date> = []
    @Published var daysLearnedCount: Int = 0
    @Published var daysFreezedCount: Int = 0
    
    // Derived property for freeze limit
    var freezeLimit: Int {
        switch timeframe {
        case "Week": return 2
        case "Month": return 8
        case "Year": return 96
        default: return 0
        }}
    
    // can the user freeze again?
    var canFreeze: Bool {
        return freezesUsed < freezeLimit}
    
    // Function to increment freeze safely
    func useFreeze() -> Bool {
        guard canFreeze else { return false } // prevent exceeding limit
        freezesUsed += 1
        return true}
    
    func logLearnedDay(_ date: Date) {
            if !learnedDays.contains(where: { Calendar.current.isDate($0, inSameDayAs: date) }) {
                learnedDays.insert(date)
                daysLearnedCount += 1
            }}
    
    func logFreezedDay(_ date: Date) -> Bool {
           guard useFreeze() else { return false }
           if !freezedDays.contains(where: { Calendar.current.isDate($0, inSameDayAs: date) }) {
               freezedDays.insert(date)
               daysFreezedCount += 1}
           return true}
    
    
}
