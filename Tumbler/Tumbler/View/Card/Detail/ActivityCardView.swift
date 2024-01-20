//
//  ActivityCardView.swift
//  Tumbler
//
//  Created by Terrence Liu on 11/4/23.
//

import SwiftUI
private let quickInfo: [(String, String)] = [("Starting", "10:18 am"), ("Latte", "$5"), ("Ice Cream", "$6")]
private let testActivity = Activity(
    id: "test-id",
    name: "Coffee Shop",
    type: Activity.ActivityType.food,
    address: "12345 SE 12th St Bellevue, WA",
    quickInfo: quickInfo, alert: "Car break-in common",
    notes: """
    Nestled on the quaint corner of Elmwood Avenue, in the heart of a bustling town, lies Whispering Beans Café, a sanctuary for coffee connoisseurs and casual sippers alike. \
    As you step through the rustic, weathered wooden door, a warm, inviting aroma envelops you, a fragrant promise of the exquisite coffee journey that awaits.

    The interior of Whispering Beans is a masterful blend of contemporary chic and vintage charm. \
    Exposed brick walls adorned with local art provide a canvas for the dance of warm, muted lighting, casting a soft, welcoming glow on the patrons. \
    Weathered leather armchairs and plush couches beckon you to settle in, while polished oak tables offer a space to gather, work, or simply lose yourself in the pages of a good book. \
    Overhead, a symphony of mellow jazz notes mingles with the quiet hum of conversations, creating a backdrop that is both soothing and invigorating.

    Behind the sleek, mahogany-topped counter, a team of passionate baristas stand ready, each a maestro in the art of brewing. \
    With gleaming espresso machines and an array of freshly sourced beans, they craft each cup with precision and care, transforming the humble coffee bean into liquid poetry. \
    Their expertise is matched only by their genuine enthusiasm to share their knowledge and help patrons discover their perfect brew."
    """
)

struct ActivityCardView: View {

    @State private var showSheet: Bool = false

    var body: some View {
        Button("Click Me") {
            showSheet.toggle()
        }
        .sheet(isPresented: $showSheet) {
            SheetActivityCardView(showSheet: $showSheet)
                .presentationDetents([.medium, .large])
        }
    }
}

struct SheetActivityCardView: View {
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
                        self.showSheet.toggle()
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
                    Text("\(testActivity.name)")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.top, 4)
                        .padding(.bottom, 2)
                        .accessibilityIdentifier("name-text")
                    // TODO: Make this a link to safari
                    Text("\(testActivity.address)")
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
                            ForEach(testActivity.quickInfo, id: \.0) { info in
                                GridRow {
                                    Text(info.0)
                                    Text(info.1)
                                }
                                .font(.callout)
                                .fontWeight(.medium)
                            }
                        }
                        .accessibilityIdentifier("quickInfo-table")

                        Text(testActivity.alert ?? "")
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

                    if selected == 1 {
                        Text(testActivity.notes ?? "No notes.")
                            .padding(.top, 3.0)
                            .fontWeight(.regular)
                            .font(.body)
                            .accessibilityIdentifier("notes-text")
                    } else {
                        Text(testActivity.name)
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
    ActivityCardView()
}
