//
//  NewActivityView.swift
//  Tumbler
//
//  Created by Vincent Liu on 1/17/24.
//

import SwiftUI
import UIKit

private let testActivity = Activity(
    id: "test-id",
    name: "Coffee House",
    type: Activity.ActivityType.food,
    address: "12345 SE 12th St Bellevue, WA 98006",
    quickInfo: [("Starting", "10:18 am"), ("Latte", "$5"), ("Ice Cream", "$6")],
    alert: "Car break-in common"
)

struct NewActivityView: View {
    @Binding var showSheet: Bool
    @State var selected = 1

    @State private var name: String = ""
    @State private var activityType: Activity.ActivityType = Activity.ActivityType.other
    @State private var timeSensitive: Bool = false
    @State private var address: String = ""
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()

    @State private var importantAlertText: String = ""
    @State private var notesText: String = ""

    @State private var newInfoText = ""

    var body: some View {
        NavigationStack {
            List {
                general
                time
                files
                Section(header: Text("Important Alerts")) {
                    TextField("Alert", text: $importantAlertText)
                        .textContentType(.givenName)
                }
                Section(header: Text("Notes")) {
                    TextEditor(text: $notesText)
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
                TextField("Activity", text: $name)
                    .textContentType(.givenName)
            }
            Picker("Type", selection: $activityType) {
                ForEach(Activity.ActivityType.allCases) { activityType in
                    Text(activityType.rawValue.capitalized)
                }
            }
            HStack(spacing: 40) {
                Text("Address")
                    .font(.body)
                    .fontWeight(.regular)
                TextField("123 St, Town, USA 12345", text: $address)
                    .textContentType(.givenName)
            }
        }
    }

    var time: some View {
        SwiftUI.Section(header: Text("Time")) {
            Toggle("Time Sensitive", isOn: $timeSensitive)
            if timeSensitive {
                DatePicker("Start", selection: $startDate, displayedComponents: [.date, .hourAndMinute])
                DatePicker(
                    "End",
                    selection: $endDate,
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
                    .foregroundColor(.blue)
            }
            HStack {
                Text("Tickets/Reservations")
                Spacer()
                Button("Upload File") {}
                    .foregroundColor(.blue)
            }
            HStack {
                Text("General Files")
                Spacer()
                Button("Upload File") {}
                    .foregroundColor(.blue)
            }
        }
    }
    
    var quickInfo: some View {
        // QuickInfo type [String: String], wait for backend-connect to be merged
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
    NewActivityView(showSheet: .constant(true))
}
