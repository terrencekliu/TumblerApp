//
//  AddActivityView.swift
//  Tumbler
//
//  Created by Vincent Liu on 2/13/24.
//

import SwiftUI

struct AddActivityView: View {
    var viewModel: NewDayViewModel

    @State private var showAddSheet = false
    @State private var selectedTime: Date = Date()

    var body: some View {
        NavigationStack {
            if viewModel.form.list.count <= 0 {
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
            List {
                ForEach(viewModel.form.list.indices, id: \.self) { idx in
                    InstanceGroup(viewModel: viewModel, instance: viewModel.form.list[idx], addIndex: idx + 1)
                        .listRowSeparator(.hidden)
                }
                .onDelete(perform: removeRow)
                .onMove { viewModel.form.list.move(fromOffsets: $0, toOffset: $1) }
            }
            .id(UUID())
            .listStyle(.insetGrouped)
            .listRowSpacing(25.0)
            .navigationTitle("Add Activities")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {
                        let message = viewModel.submitForm()
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
                AddActivitySheetView(
                    viewModel: viewModel,
                    showSheet: $showAddSheet,
                    addIndex: .constant(0)
                )
            }
        }
    }

    private func removeRow(at offsets: IndexSet) {
        viewModel.form.list.remove(atOffsets: offsets)
    }
}

struct InstanceGroup: View {
    var viewModel: NewDayViewModel
    var instance: ActivityEventGroup

    @State var addIndex: Int
    @State private var showAddSheet = false
    // TODO: Need to extract the saved time in the tuple
    @State var selectedTime: Date = Date()

    var body: some View {
        VStack {
            if instance.isEvent {
                HStack {
                    DatePicker("", selection: $selectedTime, displayedComponents: .hourAndMinute)
                        .onChange(of: selectedTime, initial: true) {
                            instance.startDate = selectedTime
                        }
                        .frame(width: 50)
                        .padding(.trailing, 20)
                    VStack { Divider().padding(.leading) }
                }
            }
            VStack {
                ActivityCard(instance: instance)
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
        }
        .sheet(isPresented: $showAddSheet) {
            AddActivitySheetView(
                viewModel: viewModel,
                showSheet: $showAddSheet,
                addIndex: $addIndex
            )
            .presentationDetents([.medium, .large])
        }
    }
}

struct ActivityCard: View {
    @Bindable var instance: ActivityEventGroup

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
            Text(instance.activity.address.address)
                .foregroundColor(.blue)
                .accessibilityIdentifier("address-text")
            TransportTabView(defaultTransport: instance.activity.defaultTransportation)
        }
    }
}

#Preview {
    let mockViewModel = ViewModel(TripDataSource.test)
    let vm = NewDayViewModel(trip: mockViewModel.trips.first!)
    vm.addInstance(activity: vm.trip.activities[0], at: 0)
    vm.addInstance(activity: vm.trip.activities[1], at: 1)
    return AddActivityView(viewModel: vm)
}
