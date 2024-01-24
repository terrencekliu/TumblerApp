//
//  TripTabView.swift
//  Tumbler
//
//  Created by Terrence Liu on 10/15/23.
//

import SwiftUI

var testTrips: [Trip] = [testTrip0, testTrip1, testTrip2]

struct TripTabView: View {

    var tripList: [Trip]

    @State private var presentAlert = false
    @State private var tripName: String = ""

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    ForEach(testTrips) {trip in
                        SimpleTripCardView(trip: trip)
                    }
                    Spacer()
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

                                    Button("Create", action: {})
                                    Button("Cancel", role: .cancel, action: {})
                                }, message: {
                                    Text("Please name your new trip.")
                                })
                        }
                    }
                }
            .navigationTitle("Trips")
            }

        }
    }

#Preview {
    TripTabView(tripList: testTrips)
}
