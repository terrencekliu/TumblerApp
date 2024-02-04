//
//  SimpleTripCardView.swift
//  Tumbler
//
//  Created by Carol Liu on 11/4/23.
//

import SwiftUI

private let testActivity = Activity(
    id: "test-id",
    name: "Coffee House",
    type: Activity.ActivityType.food,
    address: "12345 SE 12th St Bellevue, WA 98006",
    quickInfo: [("Starting", "10:18 am"), ("Latte", "$5"), ("Ice Cream", "$6")],
    alert: "Car break-in common"
)

struct SimpleActivityCardView: View {
    @State var activityName: String

    var body: some View {
        ZStack(alignment: .topLeading) {

            Image("rectangleCafe")
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 150)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .brightness(-0.2)
                .accessibilityIdentifier("preview-image")
            VStack(alignment: .leading) {
                Text(activityName)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
                    .accessibilityIdentifier("name-text")
            } .padding()
        }
    }
}

#Preview {
    SimpleActivityCardView(activityName: testActivity.name)
}
