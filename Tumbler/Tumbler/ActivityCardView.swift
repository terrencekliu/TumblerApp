//
//  ActivityCardView.swift
//  Tumbler
//
//  Created by Terrence Liu on 10/14/23.
//

import SwiftUI

let testActivity = Itinerary.Activity(id: "test-id", name: "Coffee House", type: Itinerary.ActivityType.food, address: "12345 SE 12th St Bellevue, WA 98006", quickInfo: ["Starting": "10:18 am", "Latte": "$5", "Ice Cream": "$6"], alert: "Car break-in common")

struct ActivityCardView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .foregroundColor(.white)
                .aspectRatio(3/2, contentMode: .fit)
                .overlay {
                    VStack(alignment: .leading) {
                        HStack {
                            VStack(alignment: .leading) {
                                HStack(alignment: .center) {
                                    Image(systemName: "fork.knife.circle.fill")
                                        .foregroundColor(.orange)
                                        .font(.title)
                                    Text(testActivity.name)
                                        .font(.headline)
                                }
                                HStack {
                                    // TODO: Calculate Distance
                                    Text("(\("--- ft"))")                            .foregroundColor(.gray)
                                    Text(testActivity.address)
                                        .foregroundColor(.blue)
                                }
                                .font(.footnote)
                            }
                            Spacer()
                            // TODO: Make Tickets Button Actionable
                            Button(action: {}) {
                                VStack {
                                    Image(systemName: "ticket")
                                    Text("Tickets")
                                }
                                .padding(5.0)
                            }
                            .buttonStyle(.bordered)
                        }
                        HStack(alignment: .top) {
                            Grid {
                                // TODO: Uniquely Key Values
                                ForEach(testActivity.quickInfo, id: \.key) { description, value in
                                    GridRow {
                                        Text(description)
                                        Text(value)
                                    }
                                    .gridColumnAlignment(.leading)
                                }
                                .font(.footnote)
                                .fontWeight(.medium)
                            }
                            Spacer()
                            // TODO: Replace Default Image
                            Image("cafe")
                        }
                        if testActivity.alert != nil {
                            Text(testActivity.alert!)
                                .font(.footnote)
                                .foregroundColor(Color.red)
                                .italic()
                        }
                    }
                    .padding()
                }
                .padding()
        }
    }
}

#Preview {
    ActivityCardView()
        .background(.gray)
}
