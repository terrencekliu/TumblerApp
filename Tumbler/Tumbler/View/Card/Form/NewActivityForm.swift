//
//  NewActivityForm.swift
//  Tumbler
//
//  Created by Terrence Liu on 1/28/24.
//

import Foundation

struct NewActivityForm {
    var name: String = ""
    var type: Activity.ActivityType = Activity.ActivityType.other
    var address: String = ""
    var defaultTransportation: Activity.Trans = Activity.Trans.car

    var timeSensitive: Bool = false
    var startDate = Date()
    var endDate = Date()

    var thumbnail: Bool = false
    var ticketReserve: Bool = false
    var files: Bool = false

    var quickInfo: [String: String] = [:]

    var alert: String = ""
    var notes: String = ""
}
