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
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext

    @MainActor
    static let shared = TripDataSource()

    @MainActor
    private init() {
        // swiftlint:disable force_try

        // Remove
//        let tempContainer = try! ModelContainer()
//        let tempContext = tempContainer.mainContext
//        try? tempContext.delete(model: Activity.self)
//        try? tempContext.delete(model: Event.self)
//        try? tempContext.delete(model: Day.self)
//        try? tempContext.delete(model: Trip.self)

        self.modelContainer = try! ModelContainer(for: Trip.self, Day.self, Event.self, Activity.self)
        self.modelContext = modelContainer.mainContext

        // Remove
//        try! modelContext.delete(model: Trip.self)
//        modelContext.insert(Trip(name: "Small Town Iowa"))
//        try! modelContext.save()
        // swiftlint:enable force_try
    }

    func newTrip(trip: Trip) {
        modelContext.insert(trip)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func newActivity(activity: Activity) {
        modelContext.insert(activity)
        do {
            try modelContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func newDay(day: Day) {
        modelContext.insert(day)
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

    func fetchTripActivities(tripId: UUID) -> [Activity] {
        do {
            return try modelContext.fetch(FetchDescriptor<Activity>())
        } catch {
            fatalError(error.localizedDescription)
        }
    }

    func removeTrip(_ trip: Trip) {
        modelContext.delete(trip)
    }
}
