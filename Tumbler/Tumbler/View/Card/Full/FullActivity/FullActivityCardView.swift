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
                        Text(viewModel.name)
                            .font(.headline)
                            .accessibilityIdentifier("name-text")
                    } icon: {
                        Image(systemName: "fork.knife.circle.fill")
                            .foregroundColor(.orange)
                            .font(.title)
                            .accessibilityIdentifier("type-image")
                        Text(activity.name)
                            .font(.headline)
                            .accessibilityIdentifier("name-text")
                    }
                    HStack {
                        // TODO: Calculate Distance
                        Text("(\("--- ft"))")
                            .foregroundColor(.gray)
                            .accessibilityIdentifier("distance-text")
                        Text(activity.address)
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
                        ForEach(Array(activity.quickInfo.keys), id: \.self) { key in
                            GridRow {
                                Text(key)
                                Text(activity.quickInfo[key]!)
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
    var mockViewModel = ViewModel(TripDataSource.test)
    return FullActivityCardView(activity: mockViewModel.trips.first!.activities.first!)
}
