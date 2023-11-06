//
//  Day.swift
//  Tumbler
//
//  Created by Terrence Liu on 10/16/23.
//

import Foundation

struct Day: Identifiable, Comparable {
    let id: String

    var name: String

    var startTime: Date
    var endTime: Date

    var thumbnail: Bool?

    var startEvent: Event
    var events: [Event]
    var endEvent: Event

    static func < (lhs: Day, rhs: Day) -> Bool {
        lhs.startTime < rhs.startTime
    }

    static func == (lhs: Day, rhs: Day) -> Bool {
        lhs.startTime == rhs.startTime
    }
}
