//
//  NewDayView.swift
//  Tumbler
//
//  Created by Vincent Liu on 2/5/24.
//

import SwiftUI

struct NewDayView: View {
    @State var viewModel: NewDayViewModel

    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    Section(header: Text("General")) {
                        HStack(spacing: 40) {
                            Text("Name")
                                .font(.body)
                                .fontWeight(.regular)
                            TextField("Day", text: $viewModel.form.name)
                                .textContentType(.givenName)
                        }
                        DatePicker("Start", selection: $viewModel.form.startDate, displayedComponents: [.date, .hourAndMinute])
                        // TODO: Limit user start and end time
                        DatePicker(
                            "End",
                            selection: $viewModel.form.endDate,
                            in: viewModel.form.startDate ... viewModel.form.startDate.endOfDay(),
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
                        AddActivityView(viewModel: viewModel)
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
    let testVM = NewDayViewModel(trip: mockData.trips.first!)
    return NewDayView(viewModel: testVM)
}
