//
//  AddActivitySheetView.swift
//  Tumbler
//
//  Created by Terrence Liu on 3/1/24.
//

import SwiftUI

struct AddActivitySheetViewNew: View {
    @Bindable var viewModel: NewDayViewModel

    @Binding var showAddSheet: Bool
    @Binding var addIndex: Int

    var body: some View {
        if true {
            ActivityListSheetView(
                viewModel: viewModel,
                showSheet: $showAddSheet,
                addIndex: $addIndex
            )
        } else {
            AddActivityMapView(
                viewModel: viewModel,
                showSheet: $showAddSheet,
                addIndex: $addIndex
            )
        }
    }
}
