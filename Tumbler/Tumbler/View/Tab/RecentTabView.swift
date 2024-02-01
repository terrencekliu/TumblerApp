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
            if true { // TODO: hasCurrentTrip
                VStack {
                    Text("No in progress trips :(")
                        .font(.title)
                        .padding(.bottom, 60.0)
                        .accessibilityIdentifier("no-trip-text")
                    Image("busyBee")
                        .resizable()
                        .scaledToFill()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipped()
                        .padding()
                        .accessibilityIdentifier("no-trip-image")
                    Button(action: {}) {
                        Text("Create a new trip")
                            .fontWeight(.medium)
                            .foregroundStyle(.white)
                            .frame(width: 150, height: 40)
                    }
                    .padding()
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                    .accessibilityIdentifier("new-trip-button")
                }
                .navigationTitle("In Progress")
            } else {
                ScrollView {
                    Text("Hello World!")
                }
                .navigationTitle("In Progress")
            }
        }
    }
}

#Preview {
    RecentTabView()
}
