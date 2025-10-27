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
    @Published var freezesUsed: Int = 0 //  counting freezes
    
    // Derived property for freeze limit
    var freezeLimit: Int {
        switch timeframe {
        case "Week": return 2
        case "Month": return 8
        case "Year": return 96
        default: return 0
        }
    }
    
    // can the user freeze again?
    var canFreeze: Bool {
        return freezesUsed < freezeLimit
    }
    
    // Function to increment freeze safely
    func useFreeze() -> Bool {
        guard canFreeze else { return false } // prevent exceeding limit
        freezesUsed += 1
        return true
    }
    
    
}
