//
//  FullEventCardViewModel.swift
//  Tumbler
//
//  Created by Terrence Liu on 11/4/23.
//

import Foundation

class FullEventCardViewModel: ObservableObject {
    @Published var model: Event

    init(event: Event) {
        self.model = event
    }

    var activity: Activity { model.activity }
    var otherActivities: [Activity] { model.otherActivities }
    var startTime: Date { model.startTime }
    var endTime: Date { model.endTime }
}
