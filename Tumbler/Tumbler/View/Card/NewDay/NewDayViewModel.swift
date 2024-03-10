//
//  NewDayViewModel.swift
//  Tumbler
//
//  Created by Vincent Liu on 2/13/24.
//

import Foundation
import SwiftData
import SwiftUI

@Observable
class NewDayViewModel {
    @ObservationIgnored private let dataSource: TripDataSource

    var form: NewDayForm
    var trip: Trip
    var day: Day?
    var searchTextListView: String
    var searchTextMapView: String

    var error: Error?

    init(dataSource: TripDataSource = TripDataSource.shared, trip: Trip, day: Day?) {
        self.dataSource = dataSource
        self.day = day
        self.form = day?.dayToForm() ?? NewDayForm()
        self.trip = trip
        self.searchTextListView = ""
        self.searchTextMapView = ""
    }

    private func validateForm() throws -> [Event] {
        try form.validateOrder()
        return try form.toEvent()
    }

    func submitForm() -> Bool {
        let newEvents: [Event]
        do {
            newEvents = try validateForm()
        } catch {
            self.error = error
            return false
        }

        // Write to models
        let day = Day(name: form.name, startTime: form.startDate, endTime: form.endDate)
        day.events = newEvents
        dataSource.newTripDay(self.trip, day)
        return true
    }

    func updateForm() -> Bool {
        let newEvents: [Event]
        do {
            newEvents = try validateForm()
        } catch {
            self.error = error
            return false
        }

        // Write to models
        self.removeEvents()

        self.day!.name = form.name
        self.day!.startTime = form.startDate
        self.day!.endTime = form.endDate
        self.day!.events = newEvents

        dataSource.update()
        return true
    }

    func removeEvents() {
        for event in day!.events {
            dataSource.removeEvent(event)
        }
    }

    func addInstance(activity: Activity, at index: Int) {
        let safeAddIndex = index < self.form.list.count ? index : self.form.list.count
        self.form.list.insert(ActivityEventGroup(activity), at: safeAddIndex)
    }

    func removeInstance(activity: Activity) {
        let removeIndex = self.form.list.firstIndex(where: { $0.activity == activity })!
        self.form.list.remove(at: removeIndex)
    }

    func freeActivities() -> [Activity] {
        return self.trip.activities.filter { $0.event == nil && !(form.list.map { $0.activity }.contains($0)) }
    }

    func usedActivities() -> [Activity] {
        return self.form.list.map { $0.activity }
    }
}
