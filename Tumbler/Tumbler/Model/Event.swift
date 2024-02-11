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
    var activities: [Activity] = []
    
    var startTime: Date
    var endTime: Date
    
    init(id: UUID = UUID(), activities: [Activity] = [], startTime: Date, endTime: Date) {
        self.id = id
        self.activities = activities
        self.startTime = startTime
        self.endTime = endTime
    }
    
    // TODO: Move to Extensions
    func getStartTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        return formatter.string(from: self.startTime)
    }
}
