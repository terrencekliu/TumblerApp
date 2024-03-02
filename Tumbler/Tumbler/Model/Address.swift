//
//  Address.swift
//  Tumbler
//
//  Created by Vincent Liu on 2/29/24.
//

import Foundation

struct Address: Codable, Identifiable, Equatable {
    var id: UUID = UUID()
    var label: String
    var address: String
    var latitude: Double
    var longitude: Double
}
