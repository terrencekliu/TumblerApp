//
//  AddActivitySheetView.swift
//  Tumbler
//
//  Created by Vincent Liu on 3/1/24.
//

import SwiftUI

struct AddActivitySheetView: View {
    @Bindable var viewModel: NewDayViewModel
    @Binding var showSheet: Bool
    @Binding var addIndex: Int

    @State private var displayMap: Bool = false

    var body: some View {
        NavigationStack {
            if displayMap {
                AddActivityMapView(
                    viewModel: viewModel,
                    showSheet: $showSheet,
                    addIndex: $addIndex,
                    displayMap: $displayMap
                )
            } else {
                ActivityListView(
                    viewModel: viewModel,
                    showSheet: $showSheet,
                    addIndex: $addIndex,
                    displayMap: $displayMap
                )
            }
        }
    }
}

#Preview {
    let mockData = TripViewModel(dataSource: TripDataSource.test)
    let testVM = NewDayViewModel(trip: mockData.trips.first!, day: nil)
    return AddActivitySheetView(
        viewModel: testVM,
        showSheet: .constant(true),
        addIndex: .constant(0)
    )
}
