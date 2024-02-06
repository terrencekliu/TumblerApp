//
//  NewDayView.swift
//  Tumbler
//
//  Created by Vincent Liu on 2/5/24.
//

import SwiftUI

struct NewDayView: View {
    @State private var name: String = ""
    @State private var startDate: Date = Date()
    
    // TODO: make sure that the endDate will be the same day as startDate
    @State private var endDate: Date = Date()

    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    SwiftUI.Section(header: Text("General")) {
                        HStack(spacing: 40) {
                            Text("Name")
                                .font(.body)
                                .fontWeight(.regular)
                            TextField("Day", text: $name)
                                .textContentType(.givenName)
                        }
                        DatePicker("Start", selection: $startDate, displayedComponents: [.date, .hourAndMinute])
                        // TODO: Limit user start and end time
                        DatePicker(
                            "End",
                            selection: $endDate,
                            displayedComponents: [.hourAndMinute]
                        )
                    }
                    SwiftUI.Section {
                        HStack {
                            Text("Thumbnail")
                            Spacer()
                            Button("Upload File") {}
                                .foregroundColor(.blue)
                        }
                    }
                }
                .navigationTitle("Create Day")
                .navigationBarTitleDisplayMode(.inline)
                .onAppear {
                    UITextField.appearance().clearButtonMode = .whileEditing
                }
                Button(action: {}) {
                    Text("Continue")
                        .font(.title2)
                        .fontWeight(.regular)
                        .foregroundStyle(.white)
                        .frame(width: 109, height: 50)
                }
                .buttonStyle(.borderedProminent)
                .tint(.blue)
                .accessibilityIdentifier("new-day-button")
            }
        }
    }
}

#Preview {
    NewDayView()
}
