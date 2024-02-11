//
//  TripTabView.swift
//  Tumbler
//
//  Created by Terrence Liu on 10/15/23.
//

import SwiftUI

struct TripTabView: View {
    @ObservedObject var viewModel = ViewModel()

    @State private var presentAlert = false
    @State private var tripName: String = ""

    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(viewModel.trips) { trip in
                    NavigationLink {
                        TripView(trip: trip)
                    } label: {
                        SimpleTripCardView(trip: trip)
                    }
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
            .navigationTitle("Trips")
        }
    }
}

#Preview {
    let mockViewModel = ViewModel(TripDataSource.test)
    return TripTabView(viewModel: mockViewModel)
}
