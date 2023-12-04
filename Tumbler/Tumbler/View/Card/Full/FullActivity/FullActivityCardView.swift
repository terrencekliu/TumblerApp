//
//  ActivityCardView.swift
//  Tumbler
//
//  Created by Terrence Liu on 10/14/23.
//

import SwiftUI

struct FullActivityCardView: View {
    @ObservedObject var viewModel: FullActivityViewModel

    var body: some View {
        // TODO: Turn nested stacks into grid
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    HStack(alignment: .center) {
                        Image(systemName: "fork.knife.circle.fill")
                            .foregroundColor(.orange)
                            .font(.title)
                            .accessibilityIdentifier("chip-type")
                        Text(viewModel.name)
                            .font(.headline)
                            .accessibilityIdentifier("text-name")
                    }
                    HStack {
                        // TODO: Calculate Distance
                        Text("(\("--- ft"))")
                            .foregroundColor(.gray)
                            .accessibilityIdentifier("text-distance")
                        Text(viewModel.address)
                            .foregroundColor(.blue)
                            .lineLimit(1)
                            .accessibilityIdentifier("text-address")
                    }
                    .font(.footnote)
                }
                Spacer()
                // TODO: Make Tickets Button Actionable
                Button(action: {}) {
                    VStack {
                        Image(systemName: "ticket")
                            .font(.title2)
                        Text("Tickets")
                            .font(.footnote)
                    }
                }
                .buttonStyle(.bordered)
                .accessibilityIdentifier("button-ticket")
            }
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Grid(alignment: .leading, horizontalSpacing: 40, verticalSpacing: 5) {
                        // TODO: Uniquely Key Values
                        ForEach(viewModel.quickInfo, id: \.key) { description, value in
                            GridRow {
                                Text(description)
                                Text(value)
                            }
                            .font(.footnote)
                            .fontWeight(.medium)
                        }
                    }
                    .accessibilityIdentifier("table-quickInfo")

                    Spacer()
                    Text(viewModel.alert ?? "")
                        .font(.footnote)
                        .foregroundColor(.red)
                        .italic()
                        .accessibilityIdentifier("text-alert")
                }
                Spacer()
                // TODO: Replace Default Image
                Image("cafe")
                    .accessibilityIdentifier("image-preview")
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10.0)
                .fill(.white)
        }
        .scaledToFit()
    }
}

struct FullActivityCardView_Previews: PreviewProvider {
    static let testActivity = Activity(
        id: "test-id",
        name: "Coffee House",
        type: Activity.ActivityType.food,
        address: "12345 SE 12th St Bellevue, WA 98006",
        quickInfo: ["Starting": "10:18 am", "Latte": "$5", "Ice Cream": "$6"],
        alert: "Car break-in common"
    )

    static var previews: some View {
        FullActivityCardView(
            viewModel: FullActivityViewModel(activity: testActivity)
        )
        .background(.gray)
    }
}
