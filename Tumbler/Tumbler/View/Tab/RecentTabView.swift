//
//  RecentTabView.swift
//  Tumbler
//
//  Created by Terrence Liu on 10/15/23.
//

import SwiftUI

struct RecentTabView: View {
    @ObservedObject var viewModel = ViewModel()
    @Binding var tabSelection: Int

    var body: some View {
        NavigationStack {
            var currentTrip: (Int, Trip)? = viewModel.mostCurrentTripOccurance()
            if currentTrip == nil {
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
                    Button {
                        tabSelection = 2
                    } label: {
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
                FullDayPickerView(
                    trip: currentTrip!.1,
                    selectedDay: currentTrip!.1.getSortedDays().first,
                    selectedDayNumber: currentTrip!.0
                )
            }
        }
    }
}

#Preview {
    RecentTabView(tabSelection: .constant(1))
}
