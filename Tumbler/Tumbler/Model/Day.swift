//
//  Day.swift
//  Tumbler
//
//  Created by Terrence Liu on 10/16/23.
//

import Foundation
import SwiftData

@Model
class Day: Identifiable, Comparable, Hashable, ObservableObject {
    @Attribute(.unique) let id: UUID
    var trip: Trip?
    @Attribute(.unique) let id: UUID
    var trip: Trip?

    var name: String

    var startTime: Date
    var endTime: Date

    @Attribute(.externalStorage) var thumbnail: Data?

    @Relationship(deleteRule: .nullify, inverse: \Event.day)
    var events: [Event] = []
    
    init(id: UUID = UUID(),
         name: String,
         startTime: Date,
         endTime: Date,
         thumbnail: Data? = nil,
         events: [Event] = []) {
        self.id = id
        self.name = name
        self.startTime = startTime
        self.endTime = endTime
        self.thumbnail = thumbnail
        self.events = events
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func < (lhs: Day, rhs: Day) -> Bool {
        lhs.startTime < rhs.startTime
    }

    static func == (lhs: Day, rhs: Day) -> Bool {
        lhs.startTime == rhs.startTime
    }
}
