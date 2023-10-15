//
//  Itinerary.swift
//  Tumbler
//
//  Created by Terrence Liu on 10/14/23.
//

import Foundation

struct Itinerary {
    private(set) var trips: Array<Trip>
    private(set) var days: Array<Day>
    private(set) var event: Array<Event>

    struct Trip: Identifiable {
        let id: String
        
        var name: String
        var days: Array<Day>
    }
    
    struct Day: Identifiable {
        let id: String
        
        var name: String
        
        var startTime: Date
        var endTime: Date
        
        var thumbnail: Bool?
        
        var startEvent: Event
        var events: Array<Event>
        var endEvent: Event
    }
    
    struct Event: Identifiable {
        let id: String
        
        var activity: Activity
        var otherActivities: Array<Activity>
        
        var startTime: Date?
        var endTime: Date?
    }
    
    struct Activity: Identifiable {
        let id: String
        
        var name: String
        var type: ActivityType
        var address: String
        
        var thumbnail: Bool?
        var ticketReserve: Bool?
        var files: Bool?
        
        var quickInfo: KeyValuePairs<String, String>
        
        var alert: String?
        var notes: String?
    }
    
    enum ActivityType {
        case beach
        case attraction
        case food
        case house
        case camp
    }
    
    enum TransportationType {
        case bus
        case walk
        case car
    }
}
