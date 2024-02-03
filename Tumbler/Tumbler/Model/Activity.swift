//
//  Activity.swift
//  Tumbler
//
//  Created by Terrence Liu on 10/16/23.
//

import Foundation
import SwiftData

@Model
class Activity: Identifiable, ObservableObject {
    @Attribute(.unique) let id: UUID
    var event: Event?
    var trip: Trip?

    var name: String
    var type: ActivityType
    var address: String
    var defaultTransportation: Trans

    @Attribute(.externalStorage) var thumbnail: Data?
    @Attribute(.externalStorage) var ticketReserve: Data?
    @Attribute(.externalStorage) var files: Data?

    var quickInfo: [String: String]

    var alert: String
    var notes: String
    
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

    init(id: UUID = UUID(),
         name: String,
         type: ActivityType = ActivityType.other,
         address: String,
         defaultTransportation: Trans = Trans.car,
         thumbnail: Data? = nil,
         ticketReserve: Data? = nil,
         files: Data? = nil,
         quickInfo: [String: String],
         alert: String = "",
         notes: String = "",
         trip: Trip) {
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
}
