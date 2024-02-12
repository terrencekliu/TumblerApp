//
//  TripView.swift
//  Tumbler
//
//  Created by Vincent Liu on 1/29/24.
//

import SwiftUI

struct TripView: View {
    @ObservedObject var tripViewModel = TripViewModel()
    @ObservedObject var trip: Trip

    @State private var isNewActivitySheet: Bool = false
    @State private var isActivitySheet: Bool = false
    @State private var selectedActivitySheet: Activity?
    

    private func header(_ title: String, _ seeAll: some View) -> some View {
        HStack {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .textCase(nil)
                .foregroundColor(.primary)
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
                seeAll
            } label: {
                Text("See All")
                    .textCase(nil)
            }
        }
    }

    var body: some View {
        NavigationStack {
            List {
                Section(header: header("Activities", EmptyView())) {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(tripViewModel.getActivities(tripId: trip.id)) { activity in
                                Button {
                                    selectedActivitySheet = activity
                                    isActivitySheet = true
                                } label: {
                                    SimpleActivityCardView(activityName: activity.name.capitalized)
                                }
                            }
                        }
                    }
                }
                Section(header: header("Days", EmptyView())) {
                    ForEach(trip.days) { day in
                        NavigationLink {
                            FullDayCardView(day: day)
                        } label: {
                            Text(day.name)
                        }
                    }
                }
            }
        }
        .navigationBarTitle(trip.name)
        .sheet(isPresented: $isNewActivitySheet) {
            NewActivityView(trip: trip, showSheet: $isNewActivitySheet)
                .presentationDetents([.medium, .large])
        }
        .sheet(isPresented: $isActivitySheet) {
            ActivityCardView(activity: selectedActivitySheet!, showSheet: $isActivitySheet)
                .presentationDetents([.medium, .large])
        }
    }
}

#Preview {
    var mockViewModel = ViewModel(TripDataSource.test)
    return TripView(tripViewModel: TripViewModel(dataSource: TripDataSource.test), trip: mockViewModel.trips.first!)
}
