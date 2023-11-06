//
//  ActivityCardView.swift
//  Tumbler
//
//  Created by Terrence Liu on 11/4/23.
//

import SwiftUI
let quickInfo: KeyValuePairs<String, String> = ["Starting": "10:18 am", "Latte": "$5", "Ice Cream": "$6"]
private let testActivity = Activity(id: "test-id", name: "Coffee Shop", type: Activity.ActivityType.food, address: "12345 SE 12th St Bellevue, WA", quickInfo: quickInfo, alert: "Car break-in common")

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

    var body: some View {
        VStack(alignment: .leading) {
            ZStack(alignment: .topTrailing) {
                Image("rectangleCafe")
                    .resizable()
                    .scaledToFill()
                    .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    .frame(width: 393, height: 143)
                    .clipped()
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
                .padding()
            }
            VStack(alignment: .leading) {
                Text("\(testActivity.name)")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 4)
                    .padding(.bottom, 2)
                // TODO: Make this a link to safari
                Text("\(testActivity.address)")
                    .font(.body)
                    .foregroundStyle(.blue)
                    .fontWeight(.regular)
                
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
                }
                Divider()
                    .frame(height: 0.5)
                    .overlay(.gray)
                VStack(alignment: .leading) {
                    Grid(alignment: .leading, horizontalSpacing: 40, verticalSpacing: 5) {
                        // TODO: Uniquely Key Values
                        ForEach(testActivity.quickInfo, id: \.key) { description, value in
                            GridRow {
                                Text(description)
                                Text(value)
                            }
                            .font(.callout)
                            .fontWeight(.medium)
                        }
                    }
                    Text(testActivity.alert ?? "")
                        .font(.footnote)
                        .fontWeight(.regular)
                        .foregroundColor(.red)
                        .italic()
                }
                Divider()
                    .frame(height: 0.5)
                    .overlay(.gray)
            }
            .padding(.leading, 20)
            .padding(.trailing, 20)
            Spacer()
        }
    }
}

#Preview {
    ActivityCardView()
}
