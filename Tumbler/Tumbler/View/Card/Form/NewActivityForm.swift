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
    var defaultTransportation: Trans = Trans.car

    var timeSensitive: Bool = false
    var startDate = Date()
    var endDate = Date()

    var thumbnail: Data?
    var ticketReserve: Data?
    var files: Data?

    var quickInfo: [TupleModel] = [TupleModel()]

    var alert: String = ""
    var notes: String = ""
}
