//
//  SimpleTripCardView.swift
//  Tumbler
//
//  Created by Carol Liu on 11/4/23.
//

import SwiftUI

// Testing Code -> move to testcases
private let testEvent = Event(id: "test-id", activity: testActivity, otherActivities: [testActivity], startTime: Date.now, endTime: Date.now)

private let testActivity = Activity(
    id: "test-id",
    name: "Coffee House",
    type: Activity.ActivityType.food,
    address: "12345 SE 12th St Bellevue, WA 98006",
    quickInfo: ["Starting": "10:18 am", "Latte": "$5", "Ice Cream": "$6"],
    alert: "Car break-in common"
)

private let dateNow = Date()
private let sameMonth = Date(timeIntervalSinceNow: 604800)
private let nextMonth = Date(timeIntervalSinceNow: 2629056)
private let nextYear = Date(timeIntervalSinceNow: 31622400)

private let testDay = Day(id: "test-id", name: "South Downtown", startTime: Date.now, endTime: Date.now, thumbnail: false, startEvent: testEvent, events: [testEvent, testEvent], endEvent: testEvent)

private let testDaySameMonth = Day(
    id: "test-id",
    name: "South Downtown",
    startTime: sameMonth,
    endTime: sameMonth,
    thumbnail: false,
    startEvent: testEvent,
    events: [testEvent, testEvent],
    endEvent: testEvent
)

private let testDayNextMonth = Day(
    id: "test-id",
    name: "South Downtown",
    startTime: nextMonth,
    endTime: nextMonth,
    thumbnail: false,
    startEvent: testEvent,
    events: [testEvent, testEvent],
    endEvent: testEvent
)

private let testDayNextYear = Day(
    id: "test-id",
    name: "South Downtown",
    startTime: nextYear,
    endTime: nextYear,
    thumbnail: false,
    startEvent: testEvent,
    events: [testEvent, testEvent],
    endEvent: testEvent
)

private let testDay2 = Day(
    id: "test-id",
    name: "South Downtown",
    startTime: Date.distantFuture,
    endTime: Date.distantFuture,
    thumbnail: false,
    startEvent: testEvent,
    events: [testEvent, testEvent],
    endEvent: testEvent
)

private let days: [Day] = [testDay, testDayNextMonth]
private let testTrip = Trip(id: "test-id", name: "Barcelona", days: days)

// ViewModel Stuff
// TODO: Move to ModelView
let durationText: String = testTrip.formatTripDuration()

struct SimpleTripCardView: View {
    var body: some View {
        ZStack(alignment: .topLeading) {

            Image("rectangleCafe")
                .resizable()
                .scaledToFill()
                .frame(width: 350, height: 199)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .brightness(-0.2)
            VStack(alignment: .leading) {
                Text(testActivity.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                Text("\(durationText)")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
            } .padding()
        }
    }
}

#Preview {
    SimpleTripCardView()
}
