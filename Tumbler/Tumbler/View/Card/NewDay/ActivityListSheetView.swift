//
//  ActivityListSheetView.swift
//  Tumbler
//
//  Created by Vincent Liu on 2/14/24.
//

import SwiftUI

struct ActivityListSheetView: View {
    @Bindable var viewModel: NewDayViewModel
    @Binding var showSheet: Bool
    @Binding var addIndex: Int

    var body: some View {
        NavigationStack {
            List {
                let activityGroup = viewModel.freeActivities()
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
        .searchable(text: $viewModel.searchText)
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
                            icon: { Image("rectangleCafe")
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
        if viewModel.searchText.isEmpty {
            return activities
        } else {
            return activities.filter { $0.name.localizedCaseInsensitiveContains(viewModel.searchText) }
        }
    }
}

//#Preview {
//    let mockData = ViewModel(TripDataSource.test)
//    return ActivityListSheetView(viewModel: NewDayViewModel(trip: mockData.trips.first!), showSheet: true, addIndex: 0)
//}
