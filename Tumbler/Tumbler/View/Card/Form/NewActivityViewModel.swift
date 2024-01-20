//
//  NewActivityViewModel.swift
//  Tumbler
//
//  Created by Terrence Liu on 12/23/23.
//

import Foundation

class NewActivityViewModel: ObservableObject {
    @Published var model: Activity

    init(activity: Activity) {
        self.model = activity
    }

    var name: String { model.name }
    var type: Activity.ActivityType { model.type }
    var address: String { model.address }
    var defaultTransportation: Activity.Trans { model.defaultTransportation }

    var thumbnail: Bool? { model.thumbnail }
    var ticketReserve: Bool? { model.ticketReserve }
    var files: Bool? { model.files }

    var quickInfo: [(String, String)] { model.quickInfo }

    var alert: String? { model.alert }
    var notes: String? { model.notes }
}
