//
//  DetailedActivitiyView.swift
//  Tumbler
//
//  Created by Vincent Liu on 1/23/24.
//

import SwiftUI

// Test activities for attractions
private let cityBench = Activity(
    id: "city-id",
    name: "City Bench",
    type: Activity.ActivityType.attraction,
    address: "12345 SE 12th St Bellevue, WA 98006",
    quickInfo: [("Starting", "10:18 am"), ("Latte", "$5"), ("Ice Cream", "$6")],
    alert: "Car break-in common"
)

private let rantWalk = Activity(
    id: "rant-id",
    name: "Walk of Rant",
    type: Activity.ActivityType.attraction,
    address: "12345 SE 12th St Bellevue, WA 98006",
    quickInfo: [("Starting", "10:18 am"), ("Latte", "$5"), ("Ice Cream", "$6")],
    alert: "Car break-in common"
)

private let solarPanel = Activity(
    id: "solar-id",
    name: "Solar Panel Exhibit",
    type: Activity.ActivityType.attraction,
    address: "12345 SE 12th St Bellevue, WA 98006",
    quickInfo: [("Starting", "10:18 am"), ("Latte", "$5"), ("Ice Cream", "$6")],
    alert: "Car break-in common"
)

private let eBike = Activity(
    id: "bike-id",
    name: "Electric Bike Experience",
    type: Activity.ActivityType.attraction,
    address: "12345 SE 12th St Bellevue, WA 98006",
    quickInfo: [("Starting", "10:18 am"), ("Latte", "$5"), ("Ice Cream", "$6")],
    alert: "Car break-in common"
)

// Test activities for food
private let kumNGO = Activity(
    id: "go-id",
    name: "Kum-N-Go",
    type: Activity.ActivityType.food,
    address: "12345 SE 12th St Bellevue, WA 98006",
    quickInfo: [("Starting", "10:18 am"), ("Latte", "$5"), ("Ice Cream", "$6")],
    alert: "Car break-in common"
)

private let goldenArch = Activity(
    id: "arch-id",
    name: "McDonald's",
    type: Activity.ActivityType.food,
    address: "12345 SE 12th St Bellevue, WA 98006",
    quickInfo: [("Starting", "10:18 am"), ("Latte", "$5"), ("Ice Cream", "$6")],
    alert: "Car break-in common"
)

private let lidl = Activity(
    id: "lidl-id",
    name: "Lidl",
    type: Activity.ActivityType.food,
    address: "12345 SE 12th St Bellevue, WA 98006",
    quickInfo: [("Starting", "10:18 am"), ("Latte", "$5"), ("Ice Cream", "$6")],
    alert: "Car break-in common"
)

private let pizza = Activity(
    id: "pizza-id",
    name: "Pizza Looking Thingys",
    type: Activity.ActivityType.food,
    address: "12345 SE 12th St Bellevue, WA 98006",
    quickInfo: [("Starting", "10:18 am"), ("Latte", "$5"), ("Ice Cream", "$6")],
    alert: "Car break-in common"
)

struct DetailedActivitiyView: View {

    @State private var attractions: [Activity] = [cityBench, rantWalk, solarPanel, eBike]
    @State private var foods: [Activity] = [kumNGO, goldenArch, lidl, pizza]
    @State private var beaches: [Activity] = []
    @State private var houses: [Activity] = []
    @State private var camps: [Activity] = []
    @State private var others: [Activity] = []

    var body: some View {
        NavigationView {
            ScrollView {
                if (!attractions.isEmpty) {
                    VStack {
                        HStack {
                            Image(systemName: "fork.knife.circle.fill")
                                .symbolRenderingMode(.multicolor)
                                .font(.system(size: 45))
                            Text("Attractions")
                                .font(.title)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .padding(.leading, 6)
                        Divider()
                        ForEach(attractions, id: \.id) { attraction in
                            ActivityRow(activity: attraction)
                        }
                    }
                }

                if (!foods.isEmpty) {
                    VStack {
                        HStack {
                            Image(systemName: "fork.knife.circle.fill")
                                .symbolRenderingMode(.multicolor)
                                .font(.system(size: 45))
                            Text("Food")
                                .font(.title)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .padding(.leading, 6)
                        Divider()
                        ForEach(foods, id: \.id) { food in
                            ActivityRow(activity: food)
                        }
                    }
                }

                if (!beaches.isEmpty) {
                    VStack {
                        HStack {
                            Image(systemName: "fork.knife.circle.fill")
                                .symbolRenderingMode(.multicolor)
                                .font(.system(size: 45))
                            Text("Beach")
                                .font(.title)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .padding(.leading, 6)
                        Divider()
                        ForEach(beaches, id: \.id) { beach in
                            ActivityRow(activity: beach)
                        }
                    }
                }

                if (!houses.isEmpty) {
                    VStack {
                        HStack {
                            Image(systemName: "fork.knife.circle.fill")
                                .symbolRenderingMode(.multicolor)
                                .font(.system(size: 45))
                            Text("House")
                                .font(.title)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .padding(.leading, 6)
                        Divider()
                        ForEach(houses, id: \.id) { house in
                            ActivityRow(activity: house)
                        }
                    }
                }

                if (!camps.isEmpty) {
                    VStack {
                        HStack {
                            Image(systemName: "fork.knife.circle.fill")
                                .symbolRenderingMode(.multicolor)
                                .font(.system(size: 45))
                            Text("Camp")
                                .font(.title)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .padding(.leading, 6)
                        Divider()
                        ForEach(camps, id: \.id) { camp in
                            ActivityRow(activity: camp)
                        }
                    }
                }

                if (!others.isEmpty) {
                    VStack {
                        HStack {
                            Image(systemName: "fork.knife.circle.fill")
                                .symbolRenderingMode(.multicolor)
                                .font(.system(size: 45))
                            Text("Other")
                                .font(.title)
                                .fontWeight(.bold)
                            Spacer()
                        }
                        .padding(.leading, 6)
                        Divider()
                        ForEach(others, id: \.id) { other in
                            ActivityRow(activity: other)
                        }
                    }
                }
            }
            .navigationTitle("Activities")
            .toolbar {
                Button(action: {

                }, label: {
                    Image(systemName: "plus")
                        .font(.system(size: 18))
                        .foregroundColor(Color.black)
                        .symbolRenderingMode(.monochrome)
                        .padding(.leading, 34)
                })
            }
        }
    }
}

struct ActivityRow: View {

    @State var activity: Activity

    var body: some View {
        HStack {
            Button(action: {}) {
                Image("rectangleCafe")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 40, height: 35)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                    .brightness(-0.2)
                    .accessibilityIdentifier("preview-image")
                Text(activity.name)
                    .foregroundStyle(.black)
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
                    .symbolRenderingMode(.monochrome)
            }
            .accessibilityIdentifier("new-trip-button")

            Spacer()
        }
        .padding([.leading, .trailing])
        Divider()
    }
}

#Preview {
    DetailedActivitiyView()
}
