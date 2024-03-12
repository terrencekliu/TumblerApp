//
//  DayCardView.swift
//  Tumbler
//
//  Created by Terrence Liu on 10/15/23.
//

import SwiftUI

enum TransportationSymbol: String {
    case transit = "tram.circle.fill"
    case car = "car.circle.fill"
    case walk = "figure.walk.circle.fill"
}

struct FullDayCardView: View {
    @ObservedObject var day: Day
    @State var hasDayName: Bool = false

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 1, pinnedViews: [.sectionHeaders]) {
                let events = day.events
                ForEach(Array(zip(events.indices, events)), id: \.1.id) { index, event in
                    Section {
                        // Assume that current activity is last and we need to get address from next event
                        let nextAddress: Address? = index < events.count - 1 ? events[index + 1].getActivities().first?.address : nil
                        let nextTime: Date? = index < events.count - 1 ? events[index + 1].startTime : nil
                        let lastEvent = index == events.count - 1
                        SingleEventCardView(event: event, nextAddress: nextAddress, nextTime: nextTime, lastEvent: lastEvent)
                    } header: {
                        HStack {
                            if hasDayName {
                                Text(event.startTime.format())
                                    .font(.title2)
                                    .fontWeight(.bold)
                                Spacer()
                                Text(day.name)
                                    .font(.title2)
                                    .fontWeight(.bold)
                            } else {
                                Text(event.startTime.format())
                                    .font(.title2)
                                    .fontWeight(.bold)
                                Spacer()
                            }
                        }
                        .padding()
                    }
                }
            }
        }
    }
}

struct FullDayPickerView: View {
    @ObservedObject var trip: Trip

    @State var selectedDay: Day?
    @State var selectedDayNumber: Int = 1

    @ViewBuilder
    var body: some View {
        VStack {
            if selectedDay == nil {
                Text("There are no days.")
                Text("Create a day!")
            } else {
                FullDayCardView(day: selectedDay!)
            }
        }
        .toolbarTitleMenu {
            let days = trip.getSortedDays()
            ForEach(days.indices, id: \.self) { index in
                Button("Day \(index + 1): \(days[index].name)") {
                    selectedDay = days[index]
                    selectedDayNumber = index + 1
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .toolbarColorScheme(.light, for: .navigationBar)
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(selectedDay == nil ? "" : "Day \(selectedDayNumber): \(selectedDay!.name)")
        .padding()
    }
}

struct SingleEventCardView: View {
    @ObservedObject var event: Event
    @State var nextAddress: Address?
    @State var nextTime: Date?
    @State var lastEvent: Bool = false

    var body: some View {
        let activities = event.getActivities()
        ForEach(Array(zip(activities.indices, activities)), id: \.1.id) { index, activity in
            VStack {
                FullActivityCardView(
                    activity: activity,
                    cardTint: Date() >= event.startTime && Date() < event.endTime
                        ? Color.green.opacity(0.1)
                        : Color.white
                )
                // Made assumption that current activity is last and using address of next activity of next event
                if index < activities.count - 1 {
                    TransportTabView(
                        defaultTransport: activities[index].defaultTransportation,
                        currentAddress: activity.address,
                        nextAddress: activities[index + 1].address,
                        nextTime: nextTime
                    )
                // Case of last activity
                } else if index == activities.count - 1 {
                    // Case when last activity of not the last event
                    if !lastEvent {
                        TransportTabView(
                            defaultTransport: activities[index].defaultTransportation,
                            currentAddress: activity.address,
                            nextAddress: nextAddress!,
                            nextTime: nextTime
                        )
                    // Case of last activty of last event
                    } else {
                        EmptyView()
                    }
                } else {
                    Text("Something went wrong. Please contact support.")
                }
            }
        }
    }
}

struct TransportTabView: View {
    @State var defaultTransport: Transportation
    @State var currentAddress: Address
    @State var nextAddress: Address
    @State var nextTime: Date?

    var body: some View {
        TabView(selection: $defaultTransport) {
            SimpleTransportCardView(
                viewModel: FullDayViewModel(currentAddress: currentAddress, nextAddress: nextAddress, nextTime: nextTime),
                transportSymbol: TransportationSymbol.transit,
                transportType: .transit
            )
            .tag(Transportation.transit)
            SimpleTransportCardView(
                viewModel: FullDayViewModel(currentAddress: currentAddress, nextAddress: nextAddress, nextTime: nextTime),
                transportSymbol: TransportationSymbol.car,
                transportType: .car
            )
            .tag(Transportation.car)
            SimpleTransportCardView(
                viewModel: FullDayViewModel(currentAddress: currentAddress, nextAddress: nextAddress, nextTime: nextTime),
                transportSymbol: TransportationSymbol.walk,
                transportType: .walk
            )
            .tag(Transportation.walk)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(minHeight: 75, maxHeight: 75)
    }
}

/*
 #Preview {
 let mockViewModel = ViewModel(TripDataSource.test)
 return FullDayCardView(day: mockViewModel.trips.first!.days.first!)
 }
 */
