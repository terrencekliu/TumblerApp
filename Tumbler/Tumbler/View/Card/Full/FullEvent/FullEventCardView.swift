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
        FullActivityCardView(viewModel: FullActivityViewModel(activity: viewModel.activity))
            .accessibilityLabel("activity-card")
    }
}

struct FullEventCardView_Previews: PreviewProvider {
    static let testEvent = Event(id: "test-id", activity: testActivity, otherActivities: [testActivity], startTime: Date.now, endTime: Date.now)

    static let testActivity = Activity(
        id: "test-id",
        name: "Coffee House",
        type: Activity.ActivityType.food,
        address: "12345 SE 12th St Bellevue, WA 98006",
        quickInfo: ["Starting": "10:18 am", "Latte": "$5", "Ice Cream": "$6"],
        alert: "Car break-in common"
    )

    static var previews: some View {
        FullEventCardView(
            viewModel: FullEventCardViewModel(event: testEvent)
        )
        .background(.gray)
    }
}
