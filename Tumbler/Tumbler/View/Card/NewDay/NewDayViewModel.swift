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
    var selectedPin: Activity?

    init(dataSource: TripDataSource = TripDataSource.shared, trip: Trip) {
        self.dataSource = dataSource
        self.form = NewDayForm()
        self.trip = trip
        self.searchTextListView = ""
        self.searchTextMapView = ""
        self.selectedPin = nil
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

    func freeActivities() -> [Activity] {
        return self.trip.activities.filter { $0.event == nil && !(form.list.map { $0.activity }.contains($0)) }
    }

    func usedActivities() -> [Activity] {
        return self.form.list.map { $0.activity }
    }

//    func containsActivity(of activity: Activity) -> Bool {
//        for activtyEventGroup in self.form.list where activtyEventGroup.activity == activity {
//            return true
//        }
//        return false
//    }
}
