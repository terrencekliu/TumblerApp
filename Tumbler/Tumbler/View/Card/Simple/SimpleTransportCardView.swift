//
//  SimpleTransportCardView.swift
//  Tumbler
//
//  Created by Vincent Liu on 1/24/24.
//

import SwiftUI

struct SimpleTransportCardView: View {
    let transportSymbol: TransportationSymbol
    let transportType: Transportation.TransportationType

    // State variables that need API from navigation
    @State var transitTime: String = "11:30"
    @State var transportDistance: String = "300 ft"
    @State private var destinationDistance: String = "1.2 mi"
    @State private var destinationTime: String = "1 hr 11 min"

    var body: some View {
        Button(action: {}) {
            HStack {
                Image(systemName: transportSymbol.rawValue)
                    .symbolRenderingMode(.multicolor)
                    .font(.system(size: 26))
                    .foregroundStyle(.black)
                Text("\(transportType.rawValue.capitalized)")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                if transportType == Transportation.TransportationType.transit {
                    Text("@ \(transitTime)")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                        .padding(.leading, -5)
                }

                Spacer()
                VStack {
                    Text("300 ft away")
                    HStack {
                        Text("For 100 hr 11 min \u{2022} 1111.2 mi")
                    }
                }
                .foregroundColor(.black)
                .fontWeight(.medium)
                .font(.footnote)
            }
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .tint(.blue.opacity(0.1))
        .padding([.leading, .trailing], 20)
    }
}

#Preview {
    SimpleTransportCardView(
        transportSymbol: TransportationSymbol.transit,
        transportType: Transportation.TransportationType.transit
    )
}
