//
//  Transportation.swift
//  Tumbler
//
//  Created by Terrence Liu on 10/16/23.
//

import Foundation

struct Transportation: Identifiable {
    enum TransportationType {
        case bus
        case walk
        case car
    }
    
    let id: TransportationType
    
    var timeToLeave: Date
    var minDuration: Int
    var milesAway: Double
}
