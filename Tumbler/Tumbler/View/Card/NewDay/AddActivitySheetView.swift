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

    @State private var displayOption: Int = 1

    var body: some View {
        switch displayOption {
        case 0:
            ActivityListView(viewModel: viewModel, showSheet: $showSheet, addIndex: $addIndex)
        default:
            AddActivityMapView(viewModel: viewModel, showSheet: $showSheet, addIndex: $addIndex)
        }
    }
}

#Preview {
    let mockData = TripViewModel(dataSource: TripDataSource.test)
    let testVM = NewDayViewModel(trip: mockData.trips.first!)
    return AddActivitySheetView(viewModel: testVM, showSheet: .constant(true), addIndex: .constant(0))
}
