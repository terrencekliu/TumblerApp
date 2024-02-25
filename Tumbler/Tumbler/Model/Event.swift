//
//  Event.swift
//  Tumbler
//
//  Created by Terrence Liu on 10/16/23.
//

import Foundation
import SwiftData

@Model
class Event: Identifiable, ObservableObject {
    @Attribute(.unique) let id: UUID
    var day: Day?

    @Relationship(deleteRule: .nullify, inverse: \Activity.event)
    private var activities: [Activity] = []

    var startTime: Date
    var endTime: Date

    init(id: UUID = UUID(), activities: [Activity] = [], startTime: Date, endTime: Date) {
        self.id = id
        self.startTime = startTime
        self.endTime = endTime

        // Update UUID for ordering
        activities.forEach { activity in
            activity.id = UUID()
        }
    }

    // Update UUID to keep order
    func addActivityOrder(_ activity: Activity) {
        activity.id = UUID()
        activities.append(activity)
    }

    func updateActivityOrder(_ ids: [UUID]) {
        ids.forEach { currentId in
            activities.first(where: { $0.id == currentId })?.id = UUID()
        }
    }

    func getActivities() -> [Activity] {
        activities.sort(by: { $0.id < $1.id })
        return activities
    }
}
