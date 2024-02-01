//
//  Activity.swift
//  Tumbler
//
//  Created by Terrence Liu on 10/16/23.
//

import Foundation
import SwiftData

// TODO: Add Images for tumbnail???
@Model
class Activity: Identifiable, ObservableObject {
    typealias Trans = Transportation.TransportationType

    enum ActivityType: String, CaseIterable, Identifiable, Codable {
        case beach
        case attraction
        case food
        case house
        case camp
        case other

        var id: Self { self }
    }

    @Attribute(.unique) let id: UUID
    var event: Event?
    var trip: Trip?

    init(id: UUID = UUID(), name: String,
         type: ActivityType = ActivityType.attraction, address: String,
         defaultTransportation: Trans = Trans.car, thumbnail: Bool? = nil,
         ticketReserve: Bool? = nil, files: Bool? = nil, quickInfo: [String: String],
         alert: String? = nil, notes: String? = nil, trip: Trip) {
        self.id = id
        self.name = name
        self.type = type
        self.address = address
        self.defaultTransportation = defaultTransportation
        self.thumbnail = thumbnail
        self.ticketReserve = ticketReserve
        self.files = files
        self.quickInfo = quickInfo
        self.alert = alert
        self.notes = notes
        self.trip = trip
    }

    var name: String
    var type: ActivityType
    var address: String
    var defaultTransportation: Trans

    var thumbnail: Bool?
    var ticketReserve: Bool?
    var files: Bool?

    var quickInfo: [String: String]

    var alert: String?
    var notes: String?
}
