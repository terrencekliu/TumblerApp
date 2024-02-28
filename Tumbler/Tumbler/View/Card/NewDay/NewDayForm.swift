//
//  NewDayForm.swift
//  Tumbler
//
//  Created by Terrence Liu on 2/24/24.
//

import Foundation

enum FormValidationError: Error {
    case noFirstEvent
    case unexpectedException
}

@Observable
class NewDayForm {
    var name: String = ""

    var startDate: Date = Date()
    var endDate: Date = Date()

    var list: [ActivityEventGroup] = []

    func toEvent() throws -> [Event] {
        var events: [Event] = []

        if list.count > 0 && !(list.first!.isEvent) {
            throw FormValidationError.noFirstEvent
        }

        list.forEach { instance in
            if instance.isEvent {
                events.append(Event(startTime: instance.startDate, endTime: instance.endDate))
            }
            events.last!.addActivityOrder(instance.activity)
        }

        return events
    }
}
