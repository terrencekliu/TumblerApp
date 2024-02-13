//
//  Tuple.swift
//  Tumbler
//
//  Created by Terrence Liu on 2/13/24.
//

import Foundation

struct Tuple: Identifiable, Codable, Hashable {
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

    static func == (lhs: Tuple, rhs: Tuple) -> Bool {
        return lhs.first == rhs.second && lhs.first == rhs.second
    }
}
