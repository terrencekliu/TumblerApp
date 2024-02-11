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
    @State var selected = 1

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
            .navigationBarItems(
                leading: Button(action: {
                    self.showSheet.toggle()
                    }, label: {
                        Text("Cancel").foregroundStyle(Color.blue)
                    })
                    .buttonStyle(PlainButtonStyle())
                    .accessibilityLabel("Close")
                    .accessibilityIdentifier("close-button"),
                trailing: Button(action: {
                    viewModel.addActivity(trip: trip, form: form)
                    self.showSheet.toggle()
                    }, label: {
                        Text("Add").foregroundStyle(Color.blue)
                    })
                    .buttonStyle(PlainButtonStyle())
                    .accessibilityLabel("Add")
                    .accessibilityIdentifier("close-button")
            )
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
                    .foregroundColor(.gray)
            }
            HStack {
                Text("Tickets/Reservations")
                Spacer()
                Button("Upload File") {}
                    .foregroundColor(.gray)
            }
            HStack {
                Text("General Files")
                Spacer()
                Button("Upload File") {}
                    .foregroundColor(.gray)
            }
        }
    }
    
    @State var newInfoText: String = ""
    var quickInfo: some View {
        SwiftUI.Section(header: Text("Quick Info")) {
//            HStack {
//                Button(action: {
//                }, label: {
//                    Image(systemName: "plus.circle.fill")
//                        .font(.system(size: 22))
//                        .foregroundColor(Color.green)
//                        .symbolRenderingMode(.monochrome)
//                        .padding(.leading, 34)
//                })
//                .buttonStyle(PlainButtonStyle())
//                .accessibilityLabel(Text("Close"))
//                .accessibilityIdentifier("close-button")
//                TextField("Add new item", text: $newInfoText)
//                    .textContentType(.givenName)
//            }
//            NavigationView {
//                List {
                    // TODO: Need quickInfo to be an EnviormentObject (editable)
//                    ForEach(quickInfo, id: \.0) { info in
//                        HStack {
//                            Text(info.0)
//                            Text(info.1)
//                        }
//                    } .onDelete { indexSet in
//                        quickInfo.remove(atOffsets: indexSet)
//                    } .onMove {
//                        quickInfo.move(fromOffsets: $0, toOffset: $1)
//                    }
//                }
//                .scrollContentBackground(.visible)
//                .environment(\.editMode, .constant(.active))
//            }
        }
    }
}

#Preview {
    var mockViewModel = ViewModel(TripDataSource.test)
    return NewActivityView(trip: mockViewModel.trips.first!, showSheet: .constant(true))
}
