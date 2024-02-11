//
//  DetailedActivitiyView.swift
//  Tumbler
//
//  Created by Vincent Liu on 1/23/24.
//

import SwiftUI

// TODO: May need to put type view for different symbols settings
enum ActivitySymbolName: String {
    case attraction = "fork.knife.circle.fill"
    case food = "fork.knife.circle.fil"
    case beach = "fork.knife.circle.fi"
    case house = "fork.knife.circle.f"
    case camp = "fork.knife.circle."
    case other = "fork.knife.circle"
}

enum ActivityTypePlural: String {
    case attractions
    case foods
    case beaches
    case houses
    case camps
    case others
}

struct ActivityGroup: View {
    @State var activities: [Activity]
    let symbol: ActivitySymbolName
    let activityText: ActivityTypePlural

    var body: some View {
        if !activities.isEmpty {
            VStack {
                HStack {
                    Image(systemName: "\(symbol.rawValue)")
                        .symbolRenderingMode(.multicolor)
                        .font(.system(size: 45))
                    Text("\(activityText.rawValue.capitalized)")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                }
                .padding(.leading, 6)
                Divider()
                ForEach(activities, id: \.id) { attraction in
                    ActivityRow(activity: attraction)
                }
            }
        }
    }
}

struct DetailedActivitiyView: View {

    @State var attractions: [Activity] = []
    @State private var foods: [Activity] = []
    @State private var beaches: [Activity] = []
    @State private var houses: [Activity] = []
    @State private var camps: [Activity] = []
    @State private var others: [Activity] = []

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 30) {
                    ActivityGroup(activities: attractions,
                                  symbol: ActivitySymbolName.attraction,
                                  activityText: ActivityTypePlural.attractions)
                    
                    ActivityGroup(activities: foods,
                                  symbol: ActivitySymbolName.attraction,
                                  activityText: ActivityTypePlural.foods)
                    
                    ActivityGroup(activities: beaches,
                                  symbol: ActivitySymbolName.attraction,
                                  activityText: ActivityTypePlural.beaches)
                    
                    ActivityGroup(activities: houses,
                                  symbol: ActivitySymbolName.attraction,
                                  activityText: ActivityTypePlural.houses)
                    
                    ActivityGroup(activities: camps,
                                  symbol: ActivitySymbolName.attraction,
                                  activityText: ActivityTypePlural.camps)
                    
                    ActivityGroup(activities: others,
                                  symbol: ActivitySymbolName.attraction,
                                  activityText: ActivityTypePlural.others)
                }
                .padding(.top, 30)
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
