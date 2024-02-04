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

enum ActivitySymbolName: String {
    case attractions = "fork.knife.circle.fill"
    case foods = "fork.knife.circle.fil"
    case beaches = "fork.knife.circle.fi"
    case houses = "fork.knife.circle.f"
    case camps = "fork.knife.circle."
    case others = "fork.knife.circle"
}

struct DetailedActivitiyView: View {

    @State var attractions: [Activity] = [cityBench, rantWalk, solarPanel, eBike]
    @State private var foods: [Activity] = [kumNGO, goldenArch, lidl, pizza]
    @State private var beaches: [Activity] = []
    @State private var houses: [Activity] = []
    @State private var camps: [Activity] = []
    @State private var others: [Activity] = []

    var body: some View {
        NavigationStack {
            List {
                if !attractions.isEmpty { section(attractions, ActivitySymbolName.attractions) }
                if !foods.isEmpty { section(foods, ActivitySymbolName.foods) }
                if !beaches.isEmpty { section(beaches, ActivitySymbolName.beaches) }
                if !houses.isEmpty { section(houses, ActivitySymbolName.houses) }
                if !camps.isEmpty { section(camps, ActivitySymbolName.camps) }
                if !others.isEmpty { section(others, ActivitySymbolName.others) }
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

    private func section(_ activities: [Activity], _ type: ActivitySymbolName) -> some View {
        let name = "\(type)"

        return SwiftUI.Section(header:
            HStack {
                Image(systemName: "\(type.rawValue)")
                    .symbolRenderingMode(.multicolor)
                    .font(.system(size: 45))
                Text(name.capitalized)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
            }
            .textCase(nil)
            .padding(.leading, -20.0)
        ) {
            ForEach(attractions, id: \.id) { attraction in
                ActivityRow(activity: attraction)
            }
        }
    }
}

struct ActivityRow: View {

    @State var activity: Activity

    var body: some View {
        NavigationLink {
            
        } label: {
            Label(
                title: { Text(activity.name).foregroundStyle(.black) },
                icon: { Image("rectangleCafe")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 35)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        .brightness(-0.2)
                        .accessibilityIdentifier("preview-image")
                }
            )
        }
    }
}

#Preview {
    DetailedActivitiyView()
}
