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
    var searchTextListView: String
    var searchTextMapView: String

    init(dataSource: TripDataSource = TripDataSource.shared, trip: Trip) {
        self.dataSource = dataSource
        self.form = NewDayForm()
        self.trip = trip
        self.searchTextListView = ""
        self.searchTextMapView = ""
    }

    func submitForm() -> String? {
        let day = Day(name: form.name, startTime: form.startDate, endTime: form.endDate)

        do {
            try day.events = form.toEvent()
        } catch FormValidationError.noFirstEvent {
            return "The first activity must be an event"
        } catch {
            return "There was an unexpected erorr"
        }

        dataSource.newTripDay(self.trip, day)
        return nil
    }

    func addInstance(activity: Activity, at: Int) {
        let safeAddIndex = at < self.form.list.count ? at : self.form.list.count
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
