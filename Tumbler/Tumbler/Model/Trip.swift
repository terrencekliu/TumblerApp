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

    @Relationship(deleteRule: .nullify, inverse: \Day.trip)
    private var days: [Day] = []

    @Relationship(deleteRule: .nullify, inverse: \Activity.trip)
    var activities: [Activity] = []

    init(id: UUID = UUID(), name: String, days: [Day] = [], activities: [Activity] = []) {
        self.id = id
        self.name = name
        self.days = days
        self.activities = activities
    }

    func getDays() -> [Day] {
        return days.sorted { $0.startTime < $1.startTime }
    }

    func addDay(_ day: Day) {
        days.append(day)
    }
}
