//
//  NewDayView.swift
//  Tumbler
//
//  Created by Vincent Liu on 2/5/24.
//

import SwiftUI

struct NewDayView: View {
    @EnvironmentObject var trip: Trip
    @StateObject var form: NewDayForm = NewDayForm()

    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    Section(header: Text("General")) {
                        HStack(spacing: 40) {
                            Text("Name")
                                .font(.body)
                                .fontWeight(.regular)
                            TextField("Day", text: $form.name)
                                .textContentType(.givenName)
                        }
                        DatePicker("Start", selection: $form.startDate, displayedComponents: [.date, .hourAndMinute])
                        // TODO: Limit user start and end time
                        DatePicker(
                            "End",
                            selection: $form.endDate,
                            in: form.startDate ... form.startDate.endOfDay(),
                            displayedComponents: [.hourAndMinute]
                        )
                    }
                    Section {
                        HStack {
                            Text("Thumbnail")
                            Spacer()
                            Button("Upload File") {}
                                .foregroundColor(.blue)
                        }
                    }
                    NavigationLink {
                        AddActivityView()
                            .environmentObject(form)
                            .environmentObject(trip)
                    } label: {
                        Text("Continue")
                            .foregroundColor(Color.blue)
                    }
                    .accessibilityIdentifier("new-day-button")
                }
                .navigationTitle("Create Day")
                .navigationBarTitleDisplayMode(.inline)
                .onAppear {
                    UITextField.appearance().clearButtonMode = .whileEditing
                }
            }
        }
    }
}

#Preview {
    let mockData = TripViewModel(dataSource: TripDataSource.test)
    return NewDayView()
        .environmentObject(mockData.trips.first!)
}
