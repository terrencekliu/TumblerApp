//
//  ActivityCardView.swift
//  Tumbler
//
//  Created by Terrence Liu on 11/4/23.
//

import SwiftUI

struct ActivityCardView: View {
    @ObservedObject var activity: Activity

    @Binding var showSheet: Bool
    @State var selected = 1

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ZStack(alignment: .topTrailing) {
                    Image("rectangleCafe")
                        .resizable()
                        .scaledToFill()
                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                        .frame(width: 393, height: 143)
                        .clipped()
                        .accessibilityIdentifier("preview-image")
                    Button(action: {

                    }, label: {
                        Circle()
                            .fill(.black)
                            .opacity(0.5)
                            .frame(width: 30, height: 30)
                            .overlay(
                                Image(systemName: "xmark")
                                    .font(.system(size: 15, weight: .bold, design: .rounded))
                                    .foregroundColor(.white)
                            )
                    })
                    .buttonStyle(PlainButtonStyle())
                    .accessibilityLabel(Text("Close"))
                    .accessibilityIdentifier("close-button")
                    .padding()
                }
                VStack(alignment: .leading) {
                    Text(activity.name)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 4)
                        .padding(.bottom, 2)
                        .accessibilityIdentifier("name-text")
                    // TODO: Make this a link to safari
                    Text(activity.address)
                        .font(.body)
                        .foregroundStyle(.blue)
                        .fontWeight(.regular)
                        .accessibilityIdentifier("address-text")

                    HStack {
                        Button(action: {}) {
                            VStack {
                                Image(systemName: "car.fill")
                                    .font(.title2)
                                    .foregroundStyle(.white)
                                Text("8 min")
                                    .font(.footnote)
                                    .fontWeight(.medium)
                                    .foregroundStyle(.white)
                            }
                            .frame(width: 45, height: 40)
                        }
                        .buttonStyle(.borderedProminent)
                        .tint(.blue)
                        .accessibilityIdentifier("navigate-button")
                        Button(action: {}) {
                            VStack {
                                Image(systemName: "ticket")
                                    .font(.title2)
                                Text("Tickets")
                                    .font(.footnote)
                                    .fontWeight(.medium)
                            }  .frame(width: 45, height: 40)
                        }
                        .buttonStyle(.bordered)
                        .accessibilityIdentifier("ticket-button")
                    }
                    .padding(.bottom, 4.0)
                    Divider()
                        .frame(height: 0.5)
                        .overlay(.gray)
                    VStack(alignment: .leading) {
                        Grid(alignment: .leading, horizontalSpacing: 40, verticalSpacing: 5) {
                            // TODO: Uniquely Key Values
                            // TODO: Create view for this Grid
                            ForEach(Array(activity.quickInfo.keys), id: \.self) { key in
                                GridRow {
                                    Text(key)
                                    Text(activity.quickInfo[key]!)
                                }
                                .font(.callout)
                                .fontWeight(.medium)
                            }
                        }
                        .accessibilityIdentifier("quickInfo-table")

                        Text(activity.alert ?? "")
                            .font(.footnote)
                            .fontWeight(.regular)
                            .foregroundColor(.red)
                            .italic()
                            .padding(.top, 4.0)
                            .accessibilityIdentifier("navigate-text")
                    }
                    .padding(.vertical, 3.0)
                    Divider()
                        .frame(height: 0.5)
                        .overlay(.gray)
                }
                .padding(.horizontal, 20)
                VStack {
                    Picker(selection: $selected, label: Text("Picker"), content: {
                        Text("Notes").tag(1)
                        Text("Files").tag(2)
                    })
                    .pickerStyle(SegmentedPickerStyle())
                    .frame(width: 361, height: 32)
                    .accessibilityIdentifier("details-picker")

                    switch selected {
                        case 1: Text(activity.notes ?? "No notes.")
                                .padding(.top, 3.0)
                                .fontWeight(.regular)
                                .font(.body)
                                .accessibilityIdentifier("notes-text")
                        default:
                            Text(activity.name)
                                .accessibilityIdentifier("files")
                    }
                }
                .padding(.horizontal, 20.0)
                .padding(.top, 5)
                Spacer()
            }
        }
    }
}

#Preview {
    var mockViewModel = ViewModel(TripDataSource.test)
    return ActivityCardView(activity: mockViewModel.trips.first!.activities.first!, showSheet: .constant(true))
}
