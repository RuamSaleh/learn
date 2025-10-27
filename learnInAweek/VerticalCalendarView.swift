////
////  VerticalCalendarView.swift
////  learnInAweek
////
////  Created by ruam on 05/05/1447 AH.
////
//import SwiftUI
//struct VerticalCalendarView: View {
//    let calendar = Calendar.current
//    @State var displayedMonth: Data = Calendar.current.date(from:  Calendar.current.dateComponents([.year, .month], from: Date())) ?? Date()
//    @State var currentVisiblemonth: Date = Date()
//    var body: some View {
//       
//        func monthTitle(for date: Date, full: Bool = false) -> String {
//            
//            let formatter = DateFormatter()
//            formatter.dateFormat = full ? "MMMM" : "MMM"
//            return formatter.string(from: date)
//        }
//       func genrateMonth() -> [Data] {
//           var months : [Data] = []
//           let currentYear = calendar.component(.year, from: displayedMonth)
//           for month in 1...12 {
//               if let date = calendar.date(from: DateComponents(year: currentYear, month: month)) {
//                   months.append(date)
//               }
//           }
//           return months
//            
//        }
//      
//        func genrateMonthgrid(for month: Data) -> [Data] {
//            guard let monthInterval = calendar.dateInterval(of: .month, for: month) else { return []}
//            return stride(from: monthInterval.start, to: monthInterval.end, by:86400).map{ $0 }
//            
//                
//            }
//        
//            
//        
//        
//        
//        
//        
//        
//        
//        
//        
//    }
//}
