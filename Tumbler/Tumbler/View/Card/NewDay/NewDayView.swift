//
//  NewDayView.swift
//  Tumbler
//
//  Created by Vincent Liu on 2/5/24.
//

import SwiftUI

struct NewDayView: View {
    @Environment(NavigationManager.self) private var navManager
    @Bindable var viewModel: NewDayViewModel

    var body: some View {
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
                DatePicker(
                    "End",
                    selection: $viewModel.form.endDate,
                    in: viewModel.form.startDate ... viewModel.form.startDate.endOfDay(),
                    displayedComponents: [.hourAndMinute]
                )
            }
            Button {
                @Bindable var navManager = navManager
                if viewModel.form.name.isEmpty {
                    viewModel.error = NewDayForm.Error.noDayName
                } else {
                    navManager.navigate(to: TripDestination.addActivity(form: viewModel))
                }
            } label: {
                Text("Continue").foregroundColor(Color.blue)
            }
            .accessibilityIdentifier("new-day-button")
        }
        .navigationTitle("Create Day")
        .navigationBarTitleDisplayMode(.inline)
        .errorAlert(error: $viewModel.error)
    }
}

#Preview {
    let mockData = TripViewModel(dataSource: TripDataSource.test)
    let testVM = NewDayViewModel(trip: mockData.trips.first!, day: nil)
    return NavigationStack { NewDayView(viewModel: testVM) }
}
