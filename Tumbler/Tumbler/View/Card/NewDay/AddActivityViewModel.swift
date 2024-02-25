//
//  AddActivityViewModel.swift
//  Tumbler
//
//  Created by Vincent Liu on 2/13/24.
//

import Foundation
import SwiftData

@Observable
class AddActivityViewModel: ObservableObject {
    @ObservationIgnored private let dataSource: TripDataSource

    init(dataSource: TripDataSource = TripDataSource.shared) {
        self.dataSource = dataSource
    }

    func submitForm(trip: Trip, form: NewDayForm) -> String? {
        let day = Day(name: form.name, startTime: form.startDate, endTime: form.endDate)

        do {
            try day.events = form.toEvent()
        } catch FormValidationError.noFirstEvent {
            return "The first activity must be an event"
        } catch {
            return "There was an unexpected erorr"
        }

        dataSource.newTripDay(trip, day)
        return nil
    }
}
