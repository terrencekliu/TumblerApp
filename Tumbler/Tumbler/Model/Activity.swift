//
//  Activity.swift
//  Tumbler
//
//  Created by Terrence Liu on 10/16/23.
//

import Foundation

struct Activity: Identifiable {
    enum ActivityType {
        case beach
        case attraction
        case food
        case house
        case camp
    }
    
    let id: String
    
    var name: String
    var type: ActivityType
    var address: String
    var defaultTransportation: Transportation.TransportationType = Transportation.TransportationType.car
    
    var thumbnail: Bool?
    var ticketReserve: Bool?
    var files: Bool?
    
    var quickInfo: KeyValuePairs<String, String>
    
    var alert: String?
    var notes: String?
}
