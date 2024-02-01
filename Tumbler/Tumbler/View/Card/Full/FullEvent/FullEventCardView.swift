//
//  FullEventCardView.swift
//  Tumbler
//
//  Created by Terrence Liu on 11/4/23.
//

import SwiftUI

struct FullEventCardView: View {
    @ObservedObject var viewModel: FullEventCardViewModel

    var body: some View {
        FullActivityCardView(viewModel: FullActivityViewModel(activity: viewModel.otherActivities.first!))
            .accessibilityLabel("activity-card")
    }
}

struct FullEventCardView_Previews: PreviewProvider {
    static var previews: some View {
        FullEventCardView(
            viewModel: FullEventCardViewModel(event: testEvent)
        )
        .background(.gray)
    }
}
