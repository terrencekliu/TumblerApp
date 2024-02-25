//
//  NewActivityView.swift
//  Tumbler
//
//  Created by Vincent Liu on 1/17/24.
//

import SwiftUI
import UIKit

struct NewActivityView: View {
    @ObservedObject var viewModel = NewActivityViewModel()
    @ObservedObject var trip: Trip
    @State var form = NewActivityForm()

    @Binding var showSheet: Bool

    var body: some View {
        NavigationStack {
            List {
                general
                time
                files
                Section(header: Text("Important Alerts")) {
                    TextField("Alert", text: $form.alert)
                        .textContentType(.givenName)
                }
                Section(header: Text("Notes")) {
                    TextEditor(text: $form.notes)
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
                            viewModel.addActivity(trip: trip, form: form)
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
                TextField("Activity", text: $form.name)
                    .textContentType(.givenName)
            }
            Picker("Type", selection: $form.type) {
                ForEach(Activity.ActivityType.allCases) { activityType in
                    Text(activityType.rawValue.capitalized)
                }
            }
            HStack(spacing: 40) {
                Text("Address")
                    .font(.body)
                    .fontWeight(.regular)
                TextField("123 St, Town, USA 12345", text: $form.address)
                    .textContentType(.givenName)
            }
        }
    }

    var time: some View {
        SwiftUI.Section(header: Text("Time")) {
            Toggle("Time Sensitive", isOn: $form.timeSensitive)
            if form.timeSensitive {
                DatePicker("Start", selection: $form.startDate, displayedComponents: [.date, .hourAndMinute])
                DatePicker(
                    "End",
                    selection: $form.endDate,
                    in: form.startDate ... form.startDate.endOfDay(),
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
                Button("Upload File") {}
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
            ForEach(form.quickInfo.indices, id: \.self) { index in
                HStack {
                    TextField("Label", text: $form.quickInfo[index].first)
                    TextField("Description", text: $form.quickInfo[index].second)
                }
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)
            } .onDelete { indexSet in
                form.quickInfo.remove(atOffsets: indexSet)
            } .onMove { from, to in
                form.quickInfo.move(fromOffsets: from, toOffset: to)
            }
            Button("New item", systemImage: "plus.circle.fill", action: {
                form.quickInfo.append(TupleModel())
            })
            .foregroundColor(/*@START_MENU_TOKEN@*/.green/*@END_MENU_TOKEN@*/)
        }
    }
}

#Preview {
    let mockViewModel = ViewModel(TripDataSource.test)
    return NewActivityView(trip: mockViewModel.trips.first!, showSheet: .constant(true))
}
