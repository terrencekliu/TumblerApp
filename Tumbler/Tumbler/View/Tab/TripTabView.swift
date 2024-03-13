//
//  TripTabView.swift
//  Tumbler
//
//  Created by Terrence Liu on 10/15/23.
//

import SwiftUI

struct TripTabView: View {
    @ObservedObject var viewModel = ViewModel()
    @Bindable var navManager = NavigationManager()

    @State private var presentAlert = false
    @State private var tripName: String = ""

    var body: some View {
        NavigationStack(path: $navManager.path) {
            List {
                let trips = viewModel.trips
                ForEach(trips.indices, id: \.self) { index in
                    NavigationLink(
                        value: TripDestination.trip(trip: trips[index]),
                        label: { SimpleTripCardView(trip: trips[index]) }
                    )
                    .swipeActions(edge: .trailing) {
                        Button("Delete", role: .destructive) {
                            viewModel.removeTrip(trips[index])
                            viewModel.trips.remove(at: index)
                        }
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .listRowSpacing(1)
            .listRowSeparator(.hidden)
            .toolbar {
                Button {
                    presentAlert = true
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 18))
                        .foregroundColor(Color.black)
                        .symbolRenderingMode(.monochrome)
                        .padding(.leading, 34)
                }
                .alert("Trip Name", isPresented: $presentAlert, actions: {
                    TextField("New Trip", text: $tripName)

                    Button("Create", action: {
                        viewModel.newTrip(name: tripName)
                    })
                    Button("Cancel", role: .cancel, action: {})
                }, message: {
                    Text("Please name your new trip.")
                })
            }
            .navigationDestination(for: TripDestination.self) { name in
                switch name {
                case .newDay(let trip, let day):
                    NewDayView(viewModel: NewDayViewModel(trip: trip, day: day))
                case .fullDayCard(let day):
                    FullDayCardView(day: day)
                case .detailedActivity(let activities):
                    DetailedActivityView()
                        .environment(DetailedActivityViewModel(allActivity: activities))
                case .addActivity(let form):
                    AddActivityView(viewModel: form)
                case .allDays(let trip):
                    FullDayPickerView(trip: trip, selectedDay: trip.getSortedDays().first)
                case .trip(let trip):
                    TripView(trip: trip)
                default: Text("There was an unexpected error")
                }
            }
            .navigationTitle("Trips")
        }
        .environment(navManager)
    }
}

#Preview {
    let mockViewModel = ViewModel(TripDataSource.test)
    return TripTabView(viewModel: mockViewModel)
}
