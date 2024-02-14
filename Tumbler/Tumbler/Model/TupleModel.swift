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
class Tuple: ObservableObject, Identifiable, Hashable {
    let id: UUID
    var isEvent: Bool
    var date: Date?
    var activity: Activity

    init(_ isEvent: Bool, _ date: Date?, _ activity: Activity) {
        self.id = UUID()
        self.isEvent = isEvent
        self.date = date
        self.activity = activity
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Tuple, rhs: Tuple) -> Bool {
        return lhs.activity == rhs.activity && lhs.isEvent == rhs.isEvent && lhs.date == rhs.date
    }
}

class TupleList: ObservableObject {
    @Published var tuples: [Tuple]

    init(tuples: [Tuple]) {
        self.tuples = tuples
    }
}
