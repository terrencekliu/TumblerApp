//
//  Trip.swift
//  Tumbler
//
//  Created by Terrence Liu on 10/16/23.
//

import Foundation
import SwiftData

@Model
class Trip: Identifiable, ObservableObject {
    @Attribute(.unique) let id: UUID
    var name: String

    // May have to be an array, dunno how to look up specific indexes
    // Assume always sorted?
    @Relationship(deleteRule: .nullify, inverse: \Day.trip)
    var days: [Day] = []
    @Relationship(deleteRule: .nullify, inverse: \Activity.trip)
    var activities: [Activity] = []

    init(id: UUID = UUID(), name: String, days: [Day] = [], activities: [Activity] = []) {
        self.id = id
        self.name = name
        self.days = days
        self.activities = activities
    }

    // Viewmodel Stuff
    // TODO: Move to ViewModel
    func formatTripDuration() -> String {
        if days.count < 2 {
            return ""
        }

        let formatter = DateFormatter()
        let firstDay: Day = days.first!
        let lastDay: Day = days.last!
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
}
