//
//  ViewModel.swift
//  Tumbler
//
//  Created by Terrence Liu on 1/27/24.
//

import Foundation
import SwiftData

@Observable
class ViewModel: ObservableObject {
    @ObservationIgnored
    private let dataSource: TripDataSource

    var trips: [Trip]

    init(dataSource: TripDataSource = TripDataSource.shared) {
        self.dataSource = dataSource
        trips = dataSource.fetchTrips()
    }

    func newTrip(name: String) {
        dataSource.newTrip(trip: Trip(name: name))
        trips = dataSource.fetchTrips()
    }
}
