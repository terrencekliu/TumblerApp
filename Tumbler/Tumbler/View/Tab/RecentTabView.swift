//
//  RecentTabView.swift
//  Tumbler
//
//  Created by Terrence Liu on 10/15/23.
//

import SwiftUI

func containsTrips(trips: [Trip]) -> Bool {
    return (trips.count == 0)
}

struct RecentTabView: View {
    var body: some View {
        NavigationStack {
            if containsTrips(trips: []) {
                Spacer()
                Text("No in progress trips :(")
                    .font(.title)
                    .padding(.bottom, 50.0)
                    .accessibilityIdentifier("text-noTrip-message")
                Spacer()
                Image("busyBee")
                    .resizable()
                    .scaledToFill()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 100, height: 100)
                    .clipped()
                    .padding()
                    .accessibilityIdentifier("image-noTrip-preview")
                Spacer()
                Button(action: {}) {
                    Text("Create a new trip")
                        .fontWeight(.medium)
                        .foregroundStyle(.white)
                        .frame(width: 150, height: 40)
                }
                .padding()
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                .accessibilityIdentifier("button-newTrip")
                Spacer()
                    .navigationBarTitle(Text("In Progress"))
            }
        }
    }
}

#Preview {
    RecentTabView()
}
