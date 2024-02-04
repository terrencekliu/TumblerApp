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
    
    @State private var isNewActivitySheet: Bool = false
    @State private var selectedActivitySheet: Activity?

    private func header(_ title: String) -> some View {
        HStack {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .textCase(nil)
                .foregroundColor(.black)
            Spacer()
            Button {
                isNewActivitySheet.toggle()
            } label: {
                Image(systemName: "plus")
                    .font(.system(size: 18))
                    .foregroundColor(.blue)
                    .symbolRenderingMode(.monochrome)
                    .padding(.leading, 34)
            }
            NavigationLink {

            } label: {
                Text("See All")
                    .textCase(nil)
            }
        }
    }

    var body: some View {
        NavigationStack {
            List {
                Section(header: header("Activities")) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(activities) { activity in
                                Button {
                                    selectedActivitySheet = activity
                                } label: {
                                    SimpleActivityCardView(activityName: activity.name)
                                }
                            }
                        }
                    }
                }

                Section(header: header("Days")) {
                    ForEach(days) { day in
                        NavigationLink {

                        } label: {
                            Text(day.name)
                        }
                    }
                }
            }
        }
        // Not visible with preview
        .navigationBarTitle("Barcalona")
        .sheet(isPresented: $isNewActivitySheet) {
            NewActivityView(showSheet: $isNewActivitySheet)
                .presentationDetents([.medium, .large])
        }
        .sheet(item: $selectedActivitySheet) { item in
            ActivityCardView()
                .presentationDetents([.medium, .large])
        }
        .onTapGesture {
            selectedActivitySheet = nil
        }
    }
}

#Preview {
    TripView()
}
