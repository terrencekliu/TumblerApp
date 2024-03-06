//
//  NewDayForm.swift
//  Tumbler
//
//  Created by Terrence Liu on 2/24/24.
//

import Foundation

extension NewDayForm {
    enum Error: LocalizedError {
        case noDayName, noFirstEvent, unexpectedException, nonChronologicalEvents

        var errorDescription: String? {
            switch self {
            case .noDayName: return "The day name is blank"
            case .noFirstEvent: return "The first activity must be an event"
            case .nonChronologicalEvents: return "Event times must be in order"
            case .unexpectedException: return "There was an unexpected error"
            }
        }

        var recoverySuggestion: String? {
            switch self {
            case .noDayName: return "Please add a name to the day."
            case .noFirstEvent: return "Please add a time to the first activity."
            case .nonChronologicalEvents: return "Please ensure that activitiy times are in order."
            case .unexpectedException: return "Please contact support."
            }
        }
    }
}

@Observable
class NewDayForm {
    var name: String = ""

    var startDate: Date = Date()
    var endDate: Date = Date()

    var list: [ActivityEventGroup] = []

    func validateOrder() throws {
        if !list.isSorted(by: { $0.startDate < $1.startDate }) {
            throw Error.nonChronologicalEvents
        }
    }

    func toEvent() throws -> [Event] {
        var events: [Event] = []

        if list.count > 0 && !(list.first!.isEvent) {
            throw Error.noFirstEvent
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
