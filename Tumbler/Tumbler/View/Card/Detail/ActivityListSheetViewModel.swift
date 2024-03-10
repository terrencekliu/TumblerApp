//
//  ActivityListSheetViewModel.swift
//  Tumbler
//
//  Created by Vincent Liu on 2/14/24.
//

import Foundation

class ActivityListSheetViewModel: ObservableObject {
    @Published var activities: [Activity.ActivityType: [Activity]]
    @Published var searchText: String = ""

    init(_ activities: [Activity]) {
        self.activities = Dictionary(grouping: activities, by: { $0.type })
    }
}
