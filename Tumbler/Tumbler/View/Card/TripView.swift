//
//  TripView.swift
//  Tumbler
//
//  Created by Vincent Liu on 1/29/24.
//

import SwiftUI

private let testEvent = Event(id: "test-id", activity: testActivity, otherActivities: [testActivity], startTime: Date.now, endTime: Date.now)

private let testActivity = Activity(
    id: "test-id",
    name: "Coffee House",
    type: Activity.ActivityType.food,
    address: "12345 SE 12th St Bellevue, WA 98006",
    quickInfo: [("Starting", "10:18 am"), ("Latte", "$5"), ("Ice Cream", "$6")],
    alert: "Car break-in common"
)

private let testActivity1 = Activity(
    id: "test-id1",
    name: "Beans",
    type: Activity.ActivityType.food,
    address: "12345 SE 12th St Bellevue, WA 98006",
    quickInfo: [("Starting", "10:18 am"), ("Latte", "$5"), ("Ice Cream", "$6")],
    alert: "Car break-in common"
)

private let testDay = Day(id: "test-id", name: "South Downtown", startTime: Date.now, endTime: Date.now, thumbnail: false, startEvent: testEvent, events: [testEvent, testEvent], endEvent: testEvent)
private let testDay1 = Day(id: "test-id1", name: "South Downtown", startTime: Date.now, endTime: Date.now, thumbnail: false, startEvent: testEvent, events: [testEvent, testEvent], endEvent: testEvent)

struct TripView: View {
    @State var activities: [Activity] = [testActivity, testActivity1]
    @State var days: [Day] = [testDay, testDay1]

    var body: some View {
        NavigationStack {
            Spacer()
            ZStack {
                Color.gray.opacity(0.1)

                VStack {
                    HStack(spacing: 15) {
                        Text("Activities")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                        NavigationLink {
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 18))
                                .foregroundColor(Color.blue)
                                .symbolRenderingMode(.monochrome)
                                .padding(.leading, 34)
                        }
                        NavigationLink {

                        } label: {
                            Text("See All")
                        }
                    }

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(activities) { activity in
                                NavigationLink {

                                } label: {
                                    SimpleActivityCardView()
                                }
                            }
                        }
                    }

                    HStack(spacing: 15) {
                        Text("Days")
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                        NavigationLink {
                        } label: {
                            Image(systemName: "plus")
                                .font(.system(size: 18))
                                .foregroundColor(Color.blue)
                                .symbolRenderingMode(.monochrome)
                                .padding(.leading, 34)
                        }
                        NavigationLink {

                        } label: {
                            Text("See All")
                        }
                    }
                    List {
                        ForEach(Array(zip(days.indices, days)), id: \.0) { index, day in
                            NavigationLink {
                                
                            } label: {
                                Text("Day \(index + 1): \(day.name)")
                            }
                        }
                    }
                    .listStyle(.plain)
                    Spacer()
                }
                .padding()
            }
            .navigationTitle("Barcelona")
        }
    }
}

#Preview {
    TripView()
}
