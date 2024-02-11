//
//  NewActivityViewModel.swift
//  Tumbler
//
//  Created by Terrence Liu on 12/23/23.
//

import Foundation
import SwiftData

@Observable
class NewActivityViewModel: ObservableObject {
    @ObservationIgnored private let dataSource: TripDataSource

    init(dataSource: TripDataSource = TripDataSource.shared) {
        self.dataSource = dataSource
    }

    func addActivity(trip: Trip, form: NewActivityForm) {
        let newActivity = Activity(
            name: form.name,
            type: form.type,
            address: form.address,
            defaultTransportation: form.defaultTransportation,
            thumbnail: form.thumbnail,
            ticketReserve: form.ticketReserve,
            files: form.files,
            quickInfo: form.quickInfo,
            alert: form.alert,
            notes: form.notes
        )
        trip.activities.append(newActivity)
        updateSource(activity: newActivity)
    }

    private func updateSource(activity: Activity) {
        dataSource.newActivity(activity)
        // update implicit from newActivity
    }
}
