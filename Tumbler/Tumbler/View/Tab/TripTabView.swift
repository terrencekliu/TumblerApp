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

    var body: some View {
        NavigationStack {
            Spacer()
            ForEach(testTrips) {trip in
                SimpleTripCardView(trip: trip)
            }
            Spacer()
                .navigationBarTitle(Text("Trips"))
        }
    }
}

#Preview {
    TripTabView(tripList: testTrips)
}
