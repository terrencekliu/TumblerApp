//
//  AddActivityView.swift
//  Tumbler
//
//  Created by Vincent Liu on 2/13/24.
//

import SwiftUI

struct AddActivityView: View {
    @StateObject var activityList: TupleList = TupleList(tuples: [testTuple1, testTuple2])

    @ObservedObject var viewModel = AddActivityViewModel()
    @ObservedObject var trip: Trip

    @State private var selectedTime: Date = Date()
    var body: some View {
        NavigationStack {
            List(activityList.tuples, id: \.self) { activity in
                ActivityTimeCard()
                    .environmentObject(activity)
            }
            .listSectionSpacing(.compact)
            .listStyle(.insetGrouped)
            .navigationTitle("Add Activities")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        // TODO: Pop to root view?
                    }
                }
            }
        }
    }
}

struct ActivityTimeCard: View {
    @EnvironmentObject var activity: Tuple

    // TODO: Need to extract the saved time in the tuple
    @State var selectedTime: Date = Date.distantPast

    var body: some View {
        Section {
            ActivityCard()
                .environmentObject(activity)
        } header: {
            if activity.isEvent {
                HStack {
                    DatePicker("", selection: $selectedTime, displayedComponents: .hourAndMinute)
                        .onChange(of: selectedTime, initial: true) {
                            activity.date = selectedTime
                        }
                        .frame(width: 50)
                        .padding(.trailing, 20)
                    Rectangle()
                        .frame(width: .infinity, height: 0.2)
                        .padding(.top, 1)
                }
            }
        } footer: {
            HStack {
                Spacer()
                Button {
                    
                } label: {
                    Image(systemName: "plus")
                        .padding([.leading, .trailing], 20)
                        .fontWeight(.bold)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
                Spacer()
            }
        }
        .headerProminence(.increased)
    }
}

struct ActivityCard: View {
    @EnvironmentObject var element: Tuple

    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Label {
                    Text(element.activity.name)
                        .font(.headline)
                        .fontWeight(.semibold)
                        .accessibilityIdentifier("name-text")
                } icon: {
                    Image(systemName: "fork.knife.circle.fill")
                        .foregroundColor(.orange)
                        .font(.title)
                        .accessibilityIdentifier("type-image")
                }
                Spacer()
                Toggle("", isOn: $element.isEvent)
            }
            Text(element.activity.address)
                .foregroundColor(.blue)
                .accessibilityIdentifier("address-text")
            TransportTabView(defaultTransport: element.activity.defaultTransportation)
        }
    }
}

#Preview {
    let mockViewModel = ViewModel(TripDataSource.test)
    return AddActivityView(trip: mockViewModel.trips.first!)
}
