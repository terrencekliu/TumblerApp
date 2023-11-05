//
//  Event.swift
//  Tumbler
//
//  Created by Terrence Liu on 10/16/23.
//

import Foundation

struct Event: Identifiable {
    let id: String

    var activity: Activity
    var otherActivities: [Activity]

    var startTime: Date
    var endTime: Date
}
