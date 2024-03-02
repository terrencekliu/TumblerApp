//
//  Tuple.swift
//  Tumbler
//
//  Created by Terrence Liu on 2/13/24.
//

import Foundation

struct TupleModel: Identifiable, Codable, Hashable {
    let id: UUID
    var first: String
    var second: String

    init(_ first: String, _ second: String) {
        self.id = UUID()
        self.first = first
        self.second = second
    }

    init() {
        self.id = UUID()
        self.first = ""
        self.second = ""
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: TupleModel, rhs: TupleModel) -> Bool {
        return lhs.first == rhs.second && lhs.first == rhs.second
    }
}

@Observable
class ActivityEventGroup: Identifiable, Hashable {
    let id: UUID
    var isEvent: Bool
    var startDate: Date
    var endDate: Date
    var activity: Activity

    init(_ activity: Activity, startDate: Date = Date(), endDate: Date = Date(), isEvent: Bool = false) {
        self.id = UUID()
        self.isEvent = isEvent
        self.startDate = startDate
        self.endDate = endDate
        self.activity = activity
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: ActivityEventGroup, rhs: ActivityEventGroup) -> Bool {
        return lhs.activity == rhs.activity && lhs.isEvent == rhs.isEvent &&
        lhs.startDate == rhs.startDate && lhs.endDate == rhs.endDate
    }
}
