//
//  Transportation.swift
//  Tumbler
//
//  Created by Terrence Liu on 10/16/23.
//

import Foundation

struct Transportation: Identifiable {
    enum TransportationType: String, Codable {
        case transit
        case walk
        case car
    }

    let id: String
    var type: TransportationType

    var timeToLeave: Date
    var minDuration: Int
    var milesAway: Double
}
