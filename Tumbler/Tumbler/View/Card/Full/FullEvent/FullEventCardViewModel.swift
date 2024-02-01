//
//  FullEventCardViewModel.swift
//  Tumbler
//
//  Created by Terrence Liu on 11/4/23.
//

import Foundation

class FullEventCardViewModel: ObservableObject {
    var model: Event

    init(event: Event) {
        self.model = event
    }

    var otherActivities: [Activity] { model.activities }
    var startTime: Date { model.startTime }
    var endTime: Date { model.endTime ?? model.startTime }
}
