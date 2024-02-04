//
//  DayCardView.swift
//  Tumbler
//
//  Created by Terrence Liu on 10/15/23.
//

import SwiftUI

private let testTrip = Trip(id: "newTrip", name: "TestTrip", days: [testDay, testDay1])

private let testActivity = Activity(
    id: "test-id",
    name: "Coffee House",
    type: Activity.ActivityType.food,
    address: "12345 SE 12th St Bellevue, WA 98006",
    quickInfo: [("Starting", "10:18 am"), ("Latte", "$5"), ("Ice Cream", "$6")],
    alert: "Car break-in common"
)

private let testActivity2 = Activity(
    id: "test-id1",
    name: "Beans",
    type: Activity.ActivityType.food,
    address: "12345 SE 12th St Bellevue, WA 98006",
    quickInfo: [("Starting", "10:18 am"), ("Latte", "$5"), ("Ice Cream", "$6")],
    alert: "Car break-in common"
)

private let testEvent = Event(
    id: "test-id2",
    activity: testActivity,
    otherActivities: [testActivity, testActivity2],
    startTime: Date.now,
    endTime: Date.now.advanced(by: 10)
)

private let testEvent2 = Event(
    id: "test-id3",
    activity: testActivity,
    otherActivities: [testActivity2, testActivity],
    startTime: Date.now.advanced(by: 1000),
    endTime: Date.now.advanced(by: 5000)
)

private let testDay = Day(
    id: "test-id4",
    name: "South Downtown",
    startTime: Date.now,
    endTime: Date.now,
    thumbnail: false,
    startEvent: testEvent,
    events: [testEvent, testEvent2],
    endEvent: testEvent
)

private let testDay1 = Day(
    id: "test-id5",
    name: "The Tenderloin",
    startTime: Date.now,
    endTime: Date.now,
    thumbnail: false,
    startEvent: testEvent,
    events: [testEvent2, testEvent],
    endEvent: testEvent
)

enum TransportationSymbol: String {
    case transit = "tram.circle.fill"
    case car = "car.circle.fill"
    case walk = "figure.walk.circle.fill"
}

struct FullDayCardView: View {
    @State var trip: Trip = testTrip

    @State private var scrollPosition: CGPoint = .zero
    @State private var currentDay: Day?

    var body: some View {
        ZStack {
            Color.gray.opacity(0.2).ignoresSafeArea()
            ScrollView {
                HStack {
                    Menu {
                        Picker("Day Picker", selection: $currentDay) {
                            ForEach(testTrip.days) { day in
                                Text("Day \(trip.findDayNumber(of: day)): \(day.name)").tag(day as Day?)
                            }
                        }
                    } label: {
                        HStack(spacing: 5) {
                            Text("Day \(trip.findDayNumber(of: currentDay ?? testDay)):")
                                .font(.title)
                            Text(currentDay?.name ?? testDay.name)
                                .font(.title)
                            Image(systemName: "chevron.down")
                        }
                        .foregroundStyle(.black)
                        .fontWeight(.bold)
                    }
                    Spacer()
                }
                .padding()
                LazyVStack(pinnedViews: [.sectionHeaders]) {
                    ForEach(currentDay?.events ?? testDay1.events) { event in
                        Section {
                            Divider()
                            SingleEventCardView(event: event)
                        } header: {
                            HStack {
                                Text(event.getStartTime())
                                    .font(.title2)
                                    .fontWeight(.bold)
                                Spacer()
                            }
                            .padding(.leading)
                        }
                    }
                }
                .background(GeometryReader { geometry in
                    Color.clear
                        .preference(key: ScrollOffsetPreferenceKey.self,
                                    value: geometry.frame(in: .named("scroll")).origin)
                })
                .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in self.scrollPosition = value
                }
            }
            .coordinateSpace(name: "scroll")
            if scrollPosition.y < 0 {
                VStack {
                    VStack {
                        Rectangle()
                            .fill(.gray.opacity(0.5))
                            .blur(radius: 20)
                    }
                    .frame(width: .infinity, height: 100)
                    .ignoresSafeArea()
                    Spacer()
                }
            }
        }
    }
}

struct SingleEventCardView: View {
    @State var event: Event

    var body: some View {
        VStack {
            ForEach(event.otherActivities) { activity in
                FullActivityCardView(
                    viewModel: FullActivityViewModel(activity: activity),
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
    @State var defaultTransport: Transportation.TransportationType

    var body: some View {
        TabView(selection: $defaultTransport) {
            SimpleTransportCardView(
                transportSymbol: TransportationSymbol.transit,
                transportType: Transportation.TransportationType.transit
            )
                .tag(Transportation.TransportationType.transit)
            SimpleTransportCardView(
                transportSymbol: TransportationSymbol.car,
                transportType: Transportation.TransportationType.car
            )
                .tag(Transportation.TransportationType.car)
            SimpleTransportCardView(
                transportSymbol: TransportationSymbol.walk,
                transportType: Transportation.TransportationType.walk
            )
                .tag(Transportation.TransportationType.walk)
        }
        .tabViewStyle(PageTabViewStyle())
        .frame(width: 400, height: 120)
        .onAppear {
            UIPageControl.appearance().currentPageIndicatorTintColor = .black
            UIPageControl.appearance().pageIndicatorTintColor = .systemGray2
        }
    }
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero

    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
    }
}

#Preview {
    FullDayCardView()
}
