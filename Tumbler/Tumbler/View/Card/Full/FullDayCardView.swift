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
                ForEach(day.events) { event in
                    Section {
                        SingleEventCardView(event: event)
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

    var body: some View {
        ForEach(event.getActivities()) { activity in
            VStack {
                FullActivityCardView(
                    activity: activity,
                    cardTint: Date() >= event.startTime && Date() < event.endTime
                        ? Color.green.opacity(0.1)
                        : Color.white
                )
                TransportTabView(defaultTransport: activity.defaultTransportation)
            }
        }
    }
}

struct TransportTabView: View {
    @State var defaultTransport: Transportation

    var body: some View {
        TabView(selection: $defaultTransport) {
            SimpleTransportCardView(
                transportSymbol: TransportationSymbol.transit,
                transportType: .transit
            )
                .tag(Transportation.transit)
            SimpleTransportCardView(
                transportSymbol: TransportationSymbol.car,
                transportType: .car
            )
                .tag(Transportation.car)
            SimpleTransportCardView(
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
