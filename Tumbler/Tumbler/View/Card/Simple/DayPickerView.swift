//
//  DayPickerView.swift
//  Tumbler
//
//  Created by Terrence Liu on 2/13/24.
//

import SwiftUI

struct DayPickerView: View {
    @ObservedObject var trip: Trip
    @State private var selectedDay: Day?

    var body: some View {
        NavigationStack {
            VStack {
                if selectedDay != nil {
                    FullDayCardView(day: selectedDay!)
                } else {
                    EmptyView()
                }
            }
            .toolbar {
                ToolbarTitleMenu {
                    Picker("Day Picker", selection: $selectedDay) {
                        ForEach(trip.getDays(), id: \.self.id) { day in
                            Text(day.name).tag(Optional(day))
                        }
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(selectedDay?.name ?? "Select One")
        }
    }
}

#Preview {
    let mockViewModel = ViewModel(TripDataSource.test)
    return DayPickerView(trip: mockViewModel.trips.first!)
}
