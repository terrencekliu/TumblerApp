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
    var searchText: String

    init(dataSource: TripDataSource = TripDataSource.shared, trip: Trip) {
        self.dataSource = dataSource
        self.form = NewDayForm()
        self.trip = trip
        self.searchText = ""
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
        self.form.list.insert(ActivityEventGroup(activity), at: at)
    }

    func freeActivities() -> [Activity.ActivityType: [Activity]] {
        let filtered = self.trip.activities.filter { $0.event == nil && !(form.list.map { $0.activity }.contains($0)) }
        return Dictionary(grouping: filtered, by: { $0.type })
    }
}
