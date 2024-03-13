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

    init(_ dataSource: TripDataSource = TripDataSource.shared) {
        self.dataSource = dataSource
        trips = dataSource.fetchTrips()
    }

    func newTrip(name: String) {
        dataSource.newTrip(Trip(name: name))
        trips = dataSource.fetchTrips()
    }

    func removeTrip(_ trip: Trip) {
        dataSource.removeTrip(trip)
    }

    func mostCurrentTripOccurance() -> (Int, Trip)? {
        trips = dataSource.fetchTrips()

        let selectedTrip = trips.filter { trip in
            let days = trip.getSortedDays()
            let current = Date.now
            let first = days.first?.startTime
            let last = days.last?.startTime
            return first != nil && last != nil &&
                first! <= current && current <= last!
        }.first

        if selectedTrip == nil {
            return nil
        }

        let selectedIndex = trips.firstIndex(of: selectedTrip!)
        return (selectedIndex!, selectedTrip!)
    }
}
