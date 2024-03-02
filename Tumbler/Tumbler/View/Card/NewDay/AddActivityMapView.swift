//
//  AddActivityMapView.swift
//  Tumbler
//
//  Created by Vincent Liu on 2/29/24.
//

import SwiftUI
import MapKit

struct AddActivityMapView: View {
    @Bindable var viewModel: NewDayViewModel
    @Binding var showSheet: Bool
    @Binding var addIndex: Int

    var body: some View {
        NavigationStack {
            ZStack {
                Map(selection: $viewModel.selectedPin) {
                    ForEach(searchResults(activities: viewModel.usedActivities())) { activity in
                        Marker(
                            activity.name,
                            coordinate: CLLocationCoordinate2D(
                                latitude: activity.address.latitude,
                                longitude: activity.address.longitude
                            )
                        )
                        .tag(activity)
                        .tint(.gray)
                    }
                    ForEach(searchResults(activities: viewModel.freeActivities())) { activity in
                        Marker(
                            activity.name,
                            coordinate: CLLocationCoordinate2D(
                                latitude: activity.address.latitude,
                                longitude: activity.address.longitude
                            )
                        )
                        .tag(activity)
                    }
                }
                if viewModel.selectedPin != nil {
                    ActivityPopup(viewModel: viewModel)
                }
            }
            .navigationTitle("Add Activity")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $viewModel.searchTextMapView)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        // TODO: Add the action to map page
                    }) {
                        // TODO: Change the symbol to correct symbol
                        Label("Next Page", systemImage: "square.and.arrow.up")
                    }
                }
            }
        }
    }

    private func searchResults(hasEvent: Bool = false, activities: [Activity]) -> [Activity] {
        if viewModel.searchTextMapView.isEmpty {
            return activities
        } else {
            return activities.filter { $0.name.localizedCaseInsensitiveContains(viewModel.searchTextMapView)
            }
        }
    }
}

struct ActivityPopup: View {
    @Bindable var viewModel: NewDayViewModel

    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
                    .frame(width: 349, height: 80)
                HStack {
                    Image("rectangleCafe")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 65, height: 65)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .brightness(-0.2)
                        .accessibilityIdentifier("preview-image")
                    VStack(alignment: .leading) {
                        Label {
                            Text(viewModel.selectedPin?.name ?? "No Activity Selected")
                                .font(.headline)
                                .accessibilityIdentifier("name-text")
                        } icon: {
                            Image(systemName: viewModel.selectedPin?.type.symbol.rawValue ?? Activity.ActivityType.attraction.symbol.rawValue)
                                .foregroundColor(.orange)
                                .font(.title)
                                .accessibilityIdentifier("type-image")
                        }
                        Text(viewModel.selectedPin?.address.address ?? "No Address")
                            .foregroundColor(.blue)
                            .accessibilityIdentifier("address-text")
                    }
                    Spacer()
                    if viewModel.selectedPin != nil && viewModel.freeActivities().contains(viewModel.selectedPin!) {
                        Button {
                            // TODO: Fix the at index to add
                            if viewModel.selectedPin != nil { viewModel.addInstance(activity: viewModel.selectedPin!, at: 0)
                            }
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .foregroundStyle(.blue)
                                .symbolRenderingMode(.monochrome)
                                .font(.system(size: 40))
                        }
                    } else {
                        Button {

                        } label: {
                            Image(systemName: "minus.circle.fill")
                                .foregroundStyle(.gray)
                                .symbolRenderingMode(.monochrome)
                                .font(.system(size: 40))
                        }
                    }
                    
                }
                .padding([.leading, .trailing], 30)
            }
            .padding(.top, 10)
            Spacer()
        }
    }
}

#Preview {
    let mockData = TripViewModel(dataSource: TripDataSource.test)
    let testVM = NewDayViewModel(trip: mockData.trips.first!)
    return AddActivityMapView(viewModel: testVM, showSheet: .constant(true), addIndex: .constant(0))
}
