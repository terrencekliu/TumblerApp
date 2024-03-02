//
//  TripDataSource.swift
//  Tumbler
//
//  Created by Terrence Liu on 1/27/24.
//

import Foundation
import SwiftData

// https://dev.to/jameson/swiftui-with-swiftdata-through-repository-36d1
final class TripDataSource: ObservableObject {
    private let modelConfig: ModelConfiguration
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext

    @MainActor
    static let shared = TripDataSource(mock: false)

    @MainActor
    static let test = TripDataSource(mock: true)

    @MainActor
    private init(mock: Bool) {
        // swiftlint:disable force_try
        self.modelConfig = true ?
            ModelConfiguration(isStoredInMemoryOnly: true) :
            ModelConfiguration(isStoredInMemoryOnly: false)
        self.modelContainer = try! ModelContainer(
            for: Trip.self, Day.self, Event.self, Activity.self,
            configurations: modelConfig
        )
        self.modelContext = modelContainer.mainContext

        // REMOVE
        try! self.modelContext.delete(model: Trip.self)
        try! self.modelContext.delete(model: Day.self)
        try! self.modelContext.delete(model: Event.self)
        try! self.modelContext.delete(model: Activity.self)
        newTrip(testTrip1)
//        newTrip(testTrip2)

        // swiftlint:enable force_try

        if mock {
            newTrip(testTrip1)
//            newTrip(testTrip2)
        }
    }

    func newTrip(_ trip: Trip) {
        modelContext.insert(trip)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func newActivity(_ activity: Activity) {
        modelContext.insert(activity)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func newTripDay(_ trip: Trip, _ day: Day) {
        trip.days.append(day)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func update() {
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func fetchTrips() -> [Trip] {
        do {
            return try modelContext.fetch(FetchDescriptor<Trip>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func fetchTripActivities(_ tripId: UUID) -> [Activity] {
        do {
            return try modelContext.fetch(FetchDescriptor<Activity>(
                predicate: #Predicate { activity in
                    activity.trip?.id == tripId
                },
                sortBy: [SortDescriptor(\.id), SortDescriptor(\.name)]
            ))
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func removeTrip(_ trip: Trip) {
        modelContext.delete(trip)
    }
}
