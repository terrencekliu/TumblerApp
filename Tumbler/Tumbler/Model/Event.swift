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

    // TODO: Move to Extensions
    func getStartTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        return formatter.string(from: self.startTime)
    }
}
