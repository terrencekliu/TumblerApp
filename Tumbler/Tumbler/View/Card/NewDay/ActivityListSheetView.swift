//
//  ActivityListSheetView.swift
//  Tumbler
//
//  Created by Vincent Liu on 2/14/24.
//

import SwiftUI

struct ActivityListSheetView: View {
    @EnvironmentObject var viewModel: DetailedActivityViewModel
    @EnvironmentObject var form: NewDayForm

    @Binding var showSheet: Bool
    @Binding var addIndex: Int

    var body: some View {
        NavigationStack {
            List {
                section(viewModel.activities[.attraction], ActivitySymbolName.attractions)
                section(viewModel.activities[.food], ActivitySymbolName.foods)
                section(viewModel.activities[.beach], ActivitySymbolName.beaches)
                section(viewModel.activities[.house], ActivitySymbolName.houses)
                section(viewModel.activities[.camp], ActivitySymbolName.camps)
                section(viewModel.activities[Activity.ActivityType.other], ActivitySymbolName.others)
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
                        // TODO: Move to ViewModel
                        form.list.insert(ActivityEventGroup(activity), at: addIndex)
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

#Preview {
    let mockData = ViewModel(TripDataSource.test)
    return ActivityListSheetView(showSheet: .constant(true), addIndex: .constant(0))
        .environmentObject(DetailedActivityViewModel(allActivity: mockData.trips.first!.activities))
}
