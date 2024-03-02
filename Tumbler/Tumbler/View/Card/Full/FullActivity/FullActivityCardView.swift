//
//  ActivityCardView.swift
//  Tumbler
//
//  Created by Terrence Liu on 10/14/23.
//

import SwiftUI

struct FullActivityCardView: View {
    @ObservedObject var activity: Activity

    @State var cardTint: Color = Color.white

    var body: some View {
        // TODO: Turn nested stacks into grid
        VStack(alignment: .leading) {
            HStack {
                VStack(alignment: .leading) {
                    Label {
                        Text(activity.name)
                            .font(.headline)
                            .accessibilityIdentifier("name-text")
                    } icon: {
                        Image(systemName: activity.type.symbol.rawValue)
                            .foregroundColor(.orange)
                            .font(.title)
                            .accessibilityIdentifier("type-image")
                    }
                    HStack {
                        // TODO: Calculate Distance
                        Text("(\("--- ft"))")
                            .foregroundColor(.gray)
                            .accessibilityIdentifier("distance-text")
                        Text(activity.address.address)
                            .foregroundColor(.blue)
                            .lineLimit(1)
                            .accessibilityIdentifier("address-text")
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
                .accessibilityIdentifier("ticket-button")
            }
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Grid(alignment: .leading, horizontalSpacing: 40, verticalSpacing: 5) {
                        // TODO: Uniquely Key Values
                        ForEach(Array(activity.quickInfo), id: \.self) { tuple in
                            GridRow {
                                Text(tuple.first)
                                Text(tuple.second)
                            }
                            .font(.footnote)
                            .fontWeight(.medium)
                        }
//                        Text(viewModel.quickInfo ?? "")
                    }
                    .accessibilityIdentifier("quickInfo-table")

                    Spacer()
                    Text(activity.alert ?? "")
                        .font(.footnote)
                        .foregroundColor(.red)
                        .italic()
                        .accessibilityIdentifier("alert-test")
                }
                Spacer()
                // TODO: Replace Default Image
                Image("cafe")
                    .accessibilityIdentifier("preview-image")
            }
        }
        .padding()
        .background {
            RoundedRectangle(cornerRadius: 10.0)
                .fill(cardTint)
        }
        .scaledToFit()
        .padding([.leading, .trailing], 10)
    }
}

#Preview {
    let mockViewModel = ViewModel(TripDataSource.test)
    return FullActivityCardView(activity: mockViewModel.trips.first!.activities.first!)
}
