//
//  AddActivityView.swift
//  Tumbler
//
//  Created by Vincent Liu on 2/13/24.
//

import SwiftUI

struct AddActivityView: View {
    @Environment(NavigationManager.self) private var navManager
    @Bindable var viewModel: NewDayViewModel

    @State private var showAddSheet = false
    @State private var selectedTime: Date = Date()

    var body: some View {
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
            ForEach(viewModel.form.list.indices, id: \.self) { index in
                InstanceGroup(
                    viewModel: viewModel,
                    instance: viewModel.form.list[index],
                    addIndex: index + 1
                )
                .listRowSeparator(.hidden)
            }
            .onDelete { indexSet in
                viewModel.form.list.remove(atOffsets: indexSet)
            }
            .onMove { viewModel.form.list.move(fromOffsets: $0, toOffset: $1) }
        }
        .listStyle(.insetGrouped)
        .listRowSpacing(25.0)
        .navigationTitle("Add Activities")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if viewModel.day == nil {
                    Button("Save") {
                        @Bindable var navManager = navManager
                        if viewModel.submitForm() {
                            navManager.navigateToTrip()
                        }
                    }
                } else {
                    Button("Update") {
                        @Bindable var navManager = navManager
                        if viewModel.updateForm() {
                            navManager.navigateToTrip()
                        }
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
        .errorAlert(error: $viewModel.error)
    }
}

struct InstanceGroup: View {
    var viewModel: NewDayViewModel
    @Bindable var instance: ActivityEventGroup

    @State var addIndex: Int
    @State private var showAddSheet = false

    var body: some View {
        VStack {
            if instance.isEvent {
                HStack {
                    DatePicker("", selection: $instance.startDate, displayedComponents: .hourAndMinute)
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
    let vm = NewDayViewModel(trip: mockViewModel.trips.first!, day: nil)
    vm.addInstance(activity: vm.trip.activities[0], at: 0)
    vm.addInstance(activity: vm.trip.activities[1], at: 1)
    return AddActivityView(viewModel: vm)
}
