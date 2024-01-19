//
//  NewActivityView.swift
//  Tumbler
//
//  Created by Vincent Liu on 1/17/24.
//

import SwiftUI
import UIKit

struct NewActivityView: View {
    @ObservedObject var viewModel: NewActivityViewModel

    @State private var showSheet: Bool = false

    var body: some View {
        Button("Click Me") {
            showSheet.toggle()
        }
        .sheet(isPresented: $showSheet) {
            SheetView(showSheet: $showSheet)
                .presentationDetents([.medium, .large])
        }
    }
}

struct SheetView: View {
    @Binding var showSheet: Bool
    @State var selected = 1

    @State private var name: String = ""
    @State private var activityType: Activity.ActivityType = Activity.ActivityType.other
    @State private var timeSensitive: Bool = false
    @State private var startDate: Date = Date()
    @State private var endDate: Date = Date()

    @State private var importantAlertText: String = ""
    @State private var notesText: String = ""

    @State private var quickInf = [("Starting", "10:18 am"), ("Latte", "$5"),
                                   ("Ice Cream", "$6")]
    @State private var newInfoText = ""

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                HStack {
                    Button(action: {
                        self.showSheet.toggle()
                    }, label: {
                        Text("Cancel")
                            .foregroundStyle(Color.blue)
                    })
                    .buttonStyle(PlainButtonStyle())
                    .accessibilityLabel(Text("Close"))
                    .accessibilityIdentifier("close-button")

                    Spacer()

                    Button(action: {
                        self.showSheet.toggle()
                    }, label: {
                        Text("Add")
                            .foregroundStyle(Color.blue)
                    })
                    .buttonStyle(PlainButtonStyle())
                    .accessibilityLabel(Text("Close"))
                    .accessibilityIdentifier("close-button")
                }
                VStack {
                    Text("Create New Activity")
                        .font(.title2)
                        .fontWeight(.medium)
                    
                    HStack(spacing: 60) {
                        Text("Name")
                            .font(.body)
                            .fontWeight(.regular)
                        TextField("Activity", text: $name)
                            .textContentType(.givenName)
                            .onAppear {
                                UITextField.appearance().clearButtonMode = .whileEditing
                            }
                    }
                    Divider()
                        .padding(.leading, 0)
                        .overlay(.gray)
                    HStack(spacing: 50) {
                        Text("Type")
                            .font(.body)
                            .fontWeight(.regular)
                        Spacer()
                        Picker("Choose", selection: $activityType) {
                            ForEach(Activity.ActivityType.allCases) { activityType in
                                Text(activityType.rawValue.capitalized)
                            }
                        }
                    }
                    Divider()
                        .overlay(.gray)
                    Text("Time")
                        .fontWeight(.semibold)
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack {
                        Toggle("Time Sensitive", isOn: $timeSensitive)
                    }
                    Divider()
                        .overlay(.gray)
                    if timeSensitive {
                        DatePicker("Start", selection: $startDate, displayedComponents: [.date, .hourAndMinute])
                        Divider()
                            .overlay(.gray)
                        DatePicker("End", selection: $endDate, displayedComponents: .hourAndMinute)
                        Divider()
                            .overlay(.gray)
                    }
                    Text("Files")
                        .fontWeight(.semibold)
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack {
                        Text("Thumbnail")
                        Spacer()
                        Button("Upload File") {

                        }
                        .foregroundColor(.gray)
                    }
                    Divider()
                        .overlay(.gray)
                    HStack {
                        Text("Tickets/Reservations")
                        Spacer()
                        Button("Upload File") {

                        }
                        .foregroundColor(.gray)
                    }
                    Divider()
                        .overlay(.gray)
                    HStack {
                        Text("General Files")
                        Spacer()
                        Button("Upload File") {

                        }
                        .foregroundColor(.gray)
                    }
                    Divider()
                        .overlay(.gray)
                    Text("Quick Information")
                        .fontWeight(.semibold)
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Important Alert")
                        .font(.body)
                        .fontWeight(.regular)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("", text: $importantAlertText)
                        .textContentType(.givenName)
                        .onAppear {
                            UITextField.appearance().clearButtonMode = .whileEditing
                        }
                    Divider()
                        .overlay(.gray)
                    Text("Notes")
                        .font(.body)
                        .fontWeight(.regular)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField("", text: $notesText)
                        .textContentType(.givenName)
                        .onAppear {
                            UITextField.appearance().clearButtonMode = .whileEditing
                        }
                    Divider()
                        .overlay(.gray)
                    QuickInfoView()
                }
                /*
                VStack {
                    List {
                        ForEach(quickInf, id: \.0) { info in
                            HStack {
                                Text(info.0)
                                Text(info.1)
                            }
                        } .onDelete { indexSet in
                            quickInf.remove(atOffsets: indexSet)
                        } .onMove {
                            quickInf.move(fromOffsets: $0, toOffset: $1)
                        }
                        
                    }
                    .scrollContentBackground(.hidden)
                    .environment(\.editMode, .constant(.active))
                    .scrollContentBackground(.hidden)
                }
                .frame(height: geometry.size.height)
                 */
            }
        }
        .padding([.leading, .trailing], 10)
    }
}

struct QuickInfoView: View {
    @State private var quickInf = [("Starting", "10:18 am"), ("Latte", "$5"),
                                   ("Ice Cream", "$6")]
    @State private var newInfoText = ""

    var body: some View {
        HStack(spacing: 20) {
            Button(action: {
            }, label: {
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 22))
                    .foregroundColor(Color.green)
                    .symbolRenderingMode(.monochrome)
                    .padding(.leading, 38)
            })
            .buttonStyle(PlainButtonStyle())
            .accessibilityLabel(Text("Close"))
            .accessibilityIdentifier("close-button")
            TextField("Add new item", text: $newInfoText)
                .textContentType(.givenName)
                .onAppear {
                    UITextField.appearance().clearButtonMode = .whileEditing
                }
        }
        Divider()
            .overlay(.gray)
        NavigationView {
            List {
                ForEach(quickInf, id: \.0) { info in
                    HStack {
                        Text(info.0)
                        Text(info.1)
                    }
                } .onDelete { indexSet in
                    quickInf.remove(atOffsets: indexSet)
                } .onMove {
                    quickInf.move(fromOffsets: $0, toOffset: $1)
                }

            }
            .scrollContentBackground(.visible)
            .environment(\.editMode, .constant(.active))
        }
    }
}

struct NewActivityView_Previews: PreviewProvider {
    static let testActivity = Activity(
        id: "test-id",
        name: "Coffee House",
        type: Activity.ActivityType.food,
        address: "12345 SE 12th St Bellevue, WA 98006",
        // TODO: Change quick info to array of tuples
        quickInfo: ["Starting": "10:18 am", "Latte": "$5", "Ice Cream": "$6"],
        alert: "Car break-in common"
    )

    static var previews: some View {
        NewActivityView(
            viewModel: NewActivityViewModel(activity: testActivity)
        )
    }
}
