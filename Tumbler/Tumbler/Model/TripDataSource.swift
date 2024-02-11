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

        // Remove
//        let tempContainer = try! ModelContainer()
//        let tempContext = tempContainer.mainContext
//        try? tempContext.delete(model: Activity.self)
//        try? tempContext.delete(model: Event.self)
//        try? tempContext.delete(model: Day.self)
//        try? tempContext.delete(model: Trip.self)

        self.modelConfig = mock ? 
            ModelConfiguration(isStoredInMemoryOnly: true) :
            ModelConfiguration(isStoredInMemoryOnly: false)
        self.modelContainer = try! ModelContainer(
            for: Trip.self, Day.self, Event.self, Activity.self,
            configurations: modelConfig
        )
        self.modelContext = modelContainer.mainContext

        // Remove
//            try! modelContext.delete(model: Trip.self)
//            try! modelContext.delete(model: Day.self)
//            try! modelContext.delete(model: Event.self)
//            try! modelContext.delete(model: Activity.self)
//            modelContext.insert(testTrip1)
//            try! modelContext.save()

        // swiftlint:enable force_try
        
        if mock { newTrip(testTrip1) }
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

    func newDay(_ day: Day) {
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

    func fetchTripActivities(_ tripId: UUID) -> [Activity] {
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
