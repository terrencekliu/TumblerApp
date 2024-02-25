//
//  AddActivityView.swift
//  Tumbler
//
//  Created by Vincent Liu on 2/13/24.
//

import SwiftUI

struct AddActivityView: View {
    @EnvironmentObject var trip: Trip
    @EnvironmentObject var form: NewDayForm
    @ObservedObject private var viewModel = AddActivityViewModel()

    @State private var showAddSheet = false
    @State private var selectedTime: Date = Date()
    var body: some View {
        NavigationStack {
            if form.list.count <= 0 {
                Button {
                    showAddSheet = true
                } label: {
                    Image(systemName: "plus")
                        .padding([.leading, .trailing], 20)
                        .fontWeight(.bold)
                }
                .buttonStyle(.borderedProminent)
                .buttonBorderShape(.capsule)
            }
            List(form.list.indices, id: \.self) { idx in
                InstanceGroup(addIndex: idx + 1)
                    .environmentObject(form.list[idx])
            }
            .listSectionSpacing(.compact)
            .listStyle(.insetGrouped)
            .navigationTitle("Add Activities")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        let message = viewModel.submitForm(trip: trip, form: form)
                        if message == nil {
                            print("Success")
//                            TripView(trip: trip)
                        } else {
                            print("Failure")
                        }
                    }
                }
            }
            .sheet(isPresented: $showAddSheet) {
                ActivityListSheetView(showSheet: $showAddSheet, addIndex: .constant(0))
                    .environmentObject(DetailedActivityViewModel(freeActivity: trip.activities))
                    .presentationDetents([.medium, .large])
            }
        }
    }
}

struct InstanceGroup: View {
    @EnvironmentObject var trip: Trip
    @EnvironmentObject var instance: ActivityEventGroup

    @State var addIndex: Int
    @State private var showAddSheet = false
    // TODO: Need to extract the saved time in the tuple
    @State var selectedTime: Date = Date.distantPast

    var body: some View {
        Section {
            ActivityCard()
        } header: {
            if instance.isEvent {
                HStack {
                    DatePicker("", selection: $selectedTime, displayedComponents: .hourAndMinute)
                        .onChange(of: selectedTime, initial: true) {
                            instance.startDate = selectedTime
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
                    showAddSheet = true
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
        .sheet(isPresented: $showAddSheet) {
            ActivityListSheetView(showSheet: $showAddSheet, addIndex: $addIndex)
                .environmentObject(DetailedActivityViewModel(freeActivity: trip.activities))
                .presentationDetents([.medium, .large])
        }
    }
}

struct ActivityCard: View {
    @EnvironmentObject var instance: ActivityEventGroup

    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter
    }()

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Label {
                    Text(instance.activity.name)
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
                Toggle("", isOn: $instance.isEvent)
            }
            Text(instance.activity.address)
                .foregroundColor(.blue)
                .accessibilityIdentifier("address-text")
            TransportTabView(defaultTransport: instance.activity.defaultTransportation)
        }
    }
}

#Preview {
    let mockViewModel = ViewModel(TripDataSource.test)
    return AddActivityView()
        .environmentObject(mockViewModel.trips.first!)
        .environmentObject(NewDayForm())
}
