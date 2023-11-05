//
//  Trip.swift
//  Tumbler
//
//  Created by Terrence Liu on 10/16/23.
//

import Foundation

struct Trip: Identifiable {
    let id: String
    
    var name: String
    
    // May have to be an array, dunno how to look up specific indexes
    // Assume always sorted?
    var days: [Day]
    
    // Viewmodel Stuff???
    func formatTripDuration() -> String {
        let formatter = DateFormatter()
        let firstLastDay: (Day, Day) = returnFirstLastDay()
        let firstDay: Day = firstLastDay.0
        let lastDay: Day = firstLastDay.1
        let calendar = Calendar.current
        
        let firstDayMonth = calendar.component(.month, from: firstDay.startTime)
        let lastDayMonth = calendar.component(.month, from: lastDay.startTime)
        let firstYear = calendar.component(.year, from: firstDay.startTime)
        let lastYear = calendar.component(.year, from: lastDay.startTime)
        
        formatter.dateFormat = "MMM d"
        let firstDayString: String = formatter.string(from: firstDay.startTime)
        if firstDayMonth == lastDayMonth && firstYear == lastYear {
            formatter.dateFormat = "d"
        }
        let lastDayString: String = formatter.string(from: lastDay.startTime)
        
        formatter.dateFormat = "yyyy"
        
        // Process whether year will display for both start and end day
       
        
        let firstYearString: String = formatter.string(from: firstDay.startTime)
        let lastYearString: String = formatter.string(from: lastDay.startTime)
        if firstYear == lastYear {
            return "\(firstDayString) - \(lastDayString), \(lastYearString)"
        }
        
        return "\(firstDayString), \(firstYearString) - \(lastDayString), \(lastYearString)"
    }
    
    private func returnFirstLastDay() -> (Day, Day) {
        return (days[0], days[days.count - 1])
    }
}
