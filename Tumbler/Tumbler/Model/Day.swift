//
//  Day.swift
//  Tumbler
//
//  Created by Terrence Liu on 10/16/23.
//

import Foundation
import SwiftData

@Model
class Day: Identifiable, Comparable {
    @Attribute(.unique) let id: UUID
    var trip: Trip?

    init(id: UUID = UUID(), name: String, startTime: Date, endTime: Date, thumbnail: Bool? = nil, events: [Event] = []) {
        self.id = id
        self.name = name
        self.startTime = startTime
        self.endTime = endTime
        self.thumbnail = thumbnail
        self.events = events
    }

    var name: String

    var startTime: Date
    var endTime: Date

    var thumbnail: Bool?

    @Relationship(deleteRule: .nullify, inverse: \Event.day)
    var events: [Event] = []

    static func < (lhs: Day, rhs: Day) -> Bool {
        lhs.startTime < rhs.startTime
    }

    static func == (lhs: Day, rhs: Day) -> Bool {
        lhs.startTime == rhs.startTime
    }
}
