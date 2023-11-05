//
//  Day.swift
//  Tumbler
//
//  Created by Terrence Liu on 10/16/23.
//

import Foundation

struct Day: Identifiable {
    let id: String

    var name: String

    var startTime: Date
    var endTime: Date

    var thumbnail: Bool?

    var startEvent: Event
    var events: [Event]
    var endEvent: Event
}
