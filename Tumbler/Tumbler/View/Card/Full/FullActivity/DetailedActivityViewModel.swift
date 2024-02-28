//
//  DetailedActivityViewModel.swift
//  Tumbler
//
//  Created by Terrence Liu on 10/16/23.
//

import Foundation

@Observable
class DetailedActivityViewModel {
    var activities: [Activity.ActivityType: [Activity]]
    var searchText: String = ""

    init(allActivity: [Activity]) {
        self.activities = Dictionary(grouping: allActivity, by: { $0.type })
    }

    init(freeActivity: [Activity]) {
        let filtered = freeActivity.filter { $0.event == nil }
        self.activities = Dictionary(grouping: filtered, by: { $0.type })
    }
}
