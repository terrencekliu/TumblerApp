//
//  NewActivityView.swift
//  Tumbler
//
//  Created by Vincent Liu on 1/17/24.
//

import SwiftUI
import UIKit
import PhotosUI

struct NewActivityView: View {
    @ObservedObject var viewModel = NewActivityViewModel()
    @ObservedObject var trip: Trip
    @State private var selectedPhotoItem: PhotosPickerItem?

    @Binding var showSheet: Bool

    var body: some View {
        NavigationStack {
            List {
                general
                time
                files
                Section(header: Text("Important Alerts")) {
                    TextField("Alert", text: $viewModel.form.alert)
                        .textContentType(.givenName)
                }
                Section(header: Text("Notes")) {
                    TextEditor(text: $viewModel.form.notes)
                }
                quickInfo
            }
            .listRowSeparator(.visible)
            .navigationTitle("Create New Activity")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button(
                        "Cancel",
                        action: { self.showSheet.toggle() }
                    )
                    .accessibilityLabel("Close")
                    .accessibilityIdentifier("close-button")
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button(
                        "Add",
                        action: {
                            viewModel.addActivity(trip: trip)
                            self.showSheet.toggle()
                        }
                    )
                    .accessibilityLabel("Add")
                    .accessibilityIdentifier("close-button")
                }
            }
            .onAppear {
                UITextField.appearance().clearButtonMode = .whileEditing
            }
        }
    }

    var general: some View {
        SwiftUI.Section(header: Text("General")) {
            HStack(spacing: 40) {
                Text("Name")
                    .font(.body)
                    .fontWeight(.regular)
                TextField("Activity", text: $viewModel.form.name)
                    .textContentType(.givenName)
            }
            Picker("Type", selection: $viewModel.form.type) {
                ForEach(Activity.ActivityType.allCases) { activityType in
                    Text(activityType.rawValue.capitalized)
                }
            }
            HStack(spacing: 40) {
                Text("Address")
                    .font(.body)
                    .fontWeight(.regular)
                TextField("123 St, Town, USA 12345", text: $viewModel.form.address)
                    .textContentType(.givenName)
            }
        }
    }

    var time: some View {
        SwiftUI.Section(header: Text("Time")) {
            Toggle("Time Sensitive", isOn: $viewModel.form.timeSensitive)
            if viewModel.form.timeSensitive {
                DatePicker("Start", selection: $viewModel.form.startDate, displayedComponents: [.date, .hourAndMinute])
                DatePicker(
                    "End",
                    selection: $viewModel.form.endDate,
                    in: viewModel.form.startDate ... viewModel.form.startDate.endOfDay(),
                    displayedComponents: [.hourAndMinute]
                )
            }
        }
    }

    var files: some View {
        SwiftUI.Section(header: Text("Files")) {
            HStack {
                Text("Thumbnail")
                Spacer()
                PhotosPicker("Choose Photo", selection: $selectedPhotoItem, matching: .images)
                    .onChange(of: selectedPhotoItem, initial: false) {
                        convertItemToImage()
                    }
            }
            HStack {
                Text("Tickets/Reservations")
                Spacer()
                Button("Upload File") {}
            }
            HStack {
                Text("General Files")
                Spacer()
                Button("Upload File") {}
            }
        }
    }

    var quickInfo: some View {
        SwiftUI.Section(header: Text("Quick Info")) {
            ForEach(viewModel.form.quickInfo.indices, id: \.self) { index in
                HStack {
                    TextField("Label", text: $viewModel.form.quickInfo[index].first)
                    TextField("Description", text: $viewModel.form.quickInfo[index].second)
                }
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
            } .onDelete { indexSet in
                viewModel.form.quickInfo.remove(atOffsets: indexSet)
            } .onMove { from, to in
                viewModel.form.quickInfo.move(fromOffsets: from, toOffset: to)
            }
            Button("New item", systemImage: "plus.circle.fill", action: {
                viewModel.form.quickInfo.append(TupleModel())
            })
            .foregroundColor(/*@START_MENU_TOKEN@*/.green/*@END_MENU_TOKEN@*/)
        }
    }

    private func convertItemToImage() {
        Task {
            if let imageData = try? await selectedPhotoItem?.loadTransferable(type: Data.self) {
                viewModel.form.thumbnail = imageData
            }
        }
    }
}

#Preview {
    let mockViewModel = ViewModel(TripDataSource.test)
    return NewActivityView(trip: mockViewModel.trips.first!, showSheet: .constant(true))
}
