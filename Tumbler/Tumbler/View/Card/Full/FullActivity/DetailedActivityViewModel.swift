//
//  DetailedActivityViewModel.swift
//  Tumbler
//
//  Created by Terrence Liu on 10/16/23.
//

import Foundation

class DetailedActivityViewModel: ObservableObject {
    @Published var activities: [Activity.ActivityType: [Activity]]

    init(_ activities: [Activity]) {
        self.activities = Dictionary(grouping: activities, by: { $0.type })
    }
}
