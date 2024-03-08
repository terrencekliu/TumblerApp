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
            ScrollView {
                ForEach(viewModel.trips) { trip in
                    NavigationLink(value: TripDestination.trip(trip: trip), label: { SimpleTripCardView(trip: trip) })
                }
            }
            .toolbar {
                Button(action: {
                    presentAlert = true
                }, label: {
                    Image(systemName: "plus")
                        .font(.system(size: 18))
                        .foregroundColor(Color.black)
                        .symbolRenderingMode(.monochrome)
                        .padding(.leading, 34)
                })
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
                case .newDay(let trip):
                    NewDayView(viewModel: NewDayViewModel(trip: trip))
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
