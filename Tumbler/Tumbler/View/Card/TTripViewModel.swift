//
//  TripViewModel.swift
//  Tumbler
//
//  Created by Terrence Liu on 1/29/24.
//

import Foundation

@Observable
class TTripViewModel: ObservableObject {
    @ObservationIgnored
    private let dataSource: TripDataSource

    var trips: [Trip]

    init(dataSource: TripDataSource = TripDataSource.shared) {
        self.dataSource = dataSource
        trips = dataSource.fetchTrips()
    }

    func getActivities(tripId: UUID) -> [Activity] {
        dataSource.fetchTripActivities(tripId)
    }
}
