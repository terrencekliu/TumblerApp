//
//  SimpleTransportCardView.swift
//  Tumbler
//
//  Created by Vincent Liu on 1/24/24.
//

import SwiftUI
import MapKit

struct SimpleTransportCardView: View {
    @ObservedObject var viewModel: FullDayViewModel
    let transportSymbol: TransportationSymbol
    let transportType: Transportation

    private func calculateTimeDistance() async {
        let route = await viewModel.currentAddress.fetchRoute(
            transportation: transportType,
            to: viewModel.nextAddress
        )

        if viewModel.nextTime != nil {
            viewModel.transitTime = route?.formattedLeaveTime(goal: viewModel.nextTime!) ?? "none"
        }
        viewModel.destinationTime = route?.formattedTravelTime() ?? "none"
        viewModel.destinationDistance = route?.formattedTotalDistance() ?? "none"
    }

    var body: some View {
        Button {

        } label: {
            HStack {
                Image(systemName: transportSymbol.rawValue)
                    .symbolRenderingMode(.multicolor)
                    .font(.system(size: 26))
                    .foregroundStyle(.black)
                Text("\(transportType.rawValue.capitalized)")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                if transportType == .transit {
                    Text("@ \(viewModel.transitTime)")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                        .padding(.leading, -5)
                }

                Spacer()
                VStack {
                    Text("\(viewModel.transportDistance) ft away")
                    Text("For \(viewModel.destinationTime) \u{2022} \(viewModel.destinationDistance)")
                }
                .foregroundColor(.black)
                .fontWeight(.medium)
                .font(.footnote)
            }
            .onAppear {
                Task {
                    await calculateTimeDistance()
                }
            }
        }
        .buttonStyle(.borderedProminent)
        .buttonBorderShape(.capsule)
        .tint(.blue.opacity(0.1))
        .padding([.leading, .trailing], 20)
    }
}

//#Preview {
//    SimpleTransportCardView(
//        transportSymbol: TransportationSymbol.transit,
//        transportType: .transit
//    )
//}
