//
//  ActivityListSheetView.swift
//  Tumbler
//
//  Created by Vincent Liu on 2/14/24.
//

import SwiftUI

struct ActivityListView: View {
    @Bindable var viewModel: NewDayViewModel

    @Binding var showSheet: Bool
    @Binding var addIndex: Int
    @Binding var displayMap: Bool

    var body: some View {
        NavigationStack {
            List {
                let activityGroup = Dictionary(grouping: viewModel.freeActivities(), by: { $0.type })
                section(activityGroup[.attraction], ActivitySymbolName.attractions)
                section(activityGroup[.food], ActivitySymbolName.foods)
                section(activityGroup[.beach], ActivitySymbolName.beaches)
                section(activityGroup[.house], ActivitySymbolName.houses)
                section(activityGroup[.camp], ActivitySymbolName.camps)
                section(activityGroup[Activity.ActivityType.other], ActivitySymbolName.others)
            }
            .navigationTitle("Add Activity")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        displayMap.toggle()
                    } label: {
                        Label("Map View", systemImage: "map")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showSheet.toggle()
                    } label: {
                        Label("Close", systemImage: "xmark.circle.fill")
                    }
                }
            }
        }
        .searchable(text: $viewModel.searchTextListView)
    }

    @ViewBuilder
    private func section(_ activities: [Activity]?, _ type: ActivitySymbolName) -> some View {
        if activities == nil || activities!.isEmpty {
            EmptyView()
        } else {
            let name = "\(type)"
            SwiftUI.Section(header:
                HStack {
                    Image(systemName: "\(type.rawValue)")
                        .symbolRenderingMode(.multicolor)
                        .font(.system(size: 45))
                        .foregroundStyle(.orange)
                    Text(name.capitalized)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                }
                .textCase(nil)
                .padding(.leading, -20.0)
            ) {
                ForEach(searchResults(hasEvent: true, activities: activities!), id: \.id) { activity in
                    Button {
                        viewModel.addInstance(activity: activity, at: addIndex)
                        showSheet = false
                    } label: {
                        Label(
                            title: { Text(activity.name).foregroundStyle(.black) },
                            icon: { 
                                Image("rectangleCafe")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 40, height: 35)
                                    .clipShape(RoundedRectangle(cornerRadius: 5))
                                    .brightness(-0.2)
                                    .accessibilityIdentifier("preview-image")
                            }
                        )
                    }
                }
            }
        }
    }

    private func searchResults(hasEvent: Bool = false, activities: [Activity]) -> [Activity] {
        if viewModel.searchTextListView.isEmpty {
            return activities
        } else {
            return activities.filter { $0.name.localizedCaseInsensitiveContains(viewModel.searchTextListView) }
        }
    }
}

#Preview {
    let mockData = ViewModel(TripDataSource.test)
    return ActivityListView(viewModel: NewDayViewModel(trip: mockData.trips.first!), showSheet: .constant(true), addIndex: .constant(0), displayMap: .constant(true))
}
