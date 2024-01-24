//
//  FullActivityViewModel.swift
//  Tumbler
//
//  Created by Terrence Liu on 10/16/23.
//

import Foundation

class FullActivityViewModel: ObservableObject {
    @Published var model: Activity

    init(activity: Activity) {
        self.model = activity
    }

    var name: String { model.name }
    var address: String { model.address }
    var transportation: Activity.Trans { model.defaultTransportation }
    var activityType: Activity.ActivityType { model.type }

    var alert: String? { model.alert }
    var quickInfo: [(String, String)] { model.quickInfo }
    var thumbnail: Bool? { model.thumbnail }
}
