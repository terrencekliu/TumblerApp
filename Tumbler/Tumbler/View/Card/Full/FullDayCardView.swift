//
//  DayCardView.swift
//  Tumbler
//
//  Created by Terrence Liu on 10/15/23.
//

import SwiftUI

enum TransportationSymbol: String {
    case transit = "tram.circle.fill"
    case car = "car.circle.fill"
    case walk = "figure.walk.circle.fill"
}

struct FullDayCardView: View {
    @ObservedObject var day: Day

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 1, pinnedViews: [.sectionHeaders]) {
                ForEach(day.events) { event in
                    Section {
                        SingleEventCardView(event: event)
                    } header: {
                        HStack {
                            Text(event.startTime.format())
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                            Spacer()
                        }
                        .padding()
                        .background(
                            Color.secondary
                                .colorInvert()
                                .opacity(0.75)
                                .blur(radius: /*@START_MENU_TOKEN@*/3.0/*@END_MENU_TOKEN@*/)
                        )
                    }
                }
            }
        }
        .background(Color(uiColor: UIColor.secondarySystemBackground))
        .navigationTitle(day.name)
    }
}

struct SingleEventCardView: View {
    @ObservedObject var event: Event

    var body: some View {
        ForEach(event.activities) { activity in
            VStack {
                FullActivityCardView(
                    activity: activity
//                    cardTint: Date() >= event.startTime && Date() < event.endTime
//                        ? Color.green.opacity(0.1)
//                        : Color.white
                )
                TransportTabView(defaultTransport: activity.defaultTransportation)
            }
        }
    }
}

struct TransportTabView: View {
    @State var defaultTransport: Transportation.TransportationType

    var body: some View {
        TabView(selection: $defaultTransport) {
            SimpleTransportCardView(
                transportSymbol: TransportationSymbol.transit,
                transportType: Transportation.TransportationType.transit
            )
                .tag(Transportation.TransportationType.transit)
            SimpleTransportCardView(
                transportSymbol: TransportationSymbol.car,
                transportType: Transportation.TransportationType.car
            )
                .tag(Transportation.TransportationType.car)
            SimpleTransportCardView(
                transportSymbol: TransportationSymbol.walk,
                transportType: Transportation.TransportationType.walk
            )
                .tag(Transportation.TransportationType.walk)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .frame(height: 75)
    }
}

#Preview {
    let mockViewModel = ViewModel(TripDataSource.test)
    return FullDayCardView(day: mockViewModel.trips.first!.days.first!)
}
