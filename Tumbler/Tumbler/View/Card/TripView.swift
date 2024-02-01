//
//  TripView.swift
//  Tumbler
//
//  Created by Vincent Liu on 1/29/24.
//

import SwiftUI

struct TripView: View {
    @ObservedObject private var tripViewModel = TripViewModel()
    @ObservedObject var trip: Trip

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
                            ForEach(tripViewModel.getActivities(tripId: trip.id)) { activity in
                                Button {
                                    selectedActivitySheet = activity
                                } label: {
                                    SimpleActivityCardView(activityName: activity.name.capitalized)
                                }
                            }
                        }
                    }
                }
                
                Section(header: header("Days")) {
                    ForEach(trip.days) { day in
                        NavigationLink {

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
        .sheet(item: $selectedActivitySheet) { item in
            ActivityCardView(activity: .constant(item))
                .presentationDetents([.medium, .large])
        }
        .onTapGesture {
            selectedActivitySheet = nil
        }
    }
}
