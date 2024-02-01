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
    var body: some View {
        ZStack {
            Color.gray.opacity(0.2).ignoresSafeArea()
            ScrollView {
                VStack {
                    SingleActivityCardView()
                    SingleActivityCardView()
                }
            }
        }
    }
}

struct SingleActivityCardView: View {
    var body: some View {
        VStack {
            HStack {
                Text("10:00 am")
                    .font(.title2)
                    .fontWeight(.bold)
                Rectangle()
                    .fill(Color.gray)
                    .frame(height: 1)
                    .padding(.top, -6)
                Spacer()
            }
            .padding(.leading)
            FullActivityCardView(
                viewModel: FullActivityViewModel(activity: testActivity)
            )
            TransportTabView()
        }
    }
}

struct TransportTabView: View {

    @State var defaultTransport: Transportation.TransportationType = Transportation.TransportationType.transit

    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .black
        UIPageControl.appearance().pageIndicatorTintColor = .systemGray2
    }

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
        .tabViewStyle(PageTabViewStyle())
        .frame(width: 400, height: 120)
    }
}

#Preview {
    FullDayCardView()
}
