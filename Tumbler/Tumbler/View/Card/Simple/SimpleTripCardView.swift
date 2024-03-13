//
//  SimpleTripCardView.swift
//  Tumbler
//
//  Created by Carol Liu on 11/4/23.
//

import SwiftUI

struct SimpleTripCardView: View {
    var trip: Trip

    var body: some View {
        ZStack(alignment: .topLeading) {
            let image: UIImage? = trip.activities.first?.thumbnail?.toUImage()
            if image != nil {
                Image(uiImage: image!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: .infinity, height: 199)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .brightness(-0.2)
                    .accessibilityIdentifier("preview-image")
                    .padding(.horizontal)
            } else {
                Image("rectangleCafe")
                    .resizable()
                    .scaledToFill()
                    .frame(width: .infinity, height: 199)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .brightness(-0.2)
                    .accessibilityIdentifier("preview-image")
                    .padding(.horizontal)
            }
            VStack(alignment: .leading) {
                Text(trip.name)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .accessibilityIdentifier("name-text")
                    .truncationMode(.middle)
                Text("\(trip.formatTripDuration())")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
                    .accessibilityIdentifier("date-range-text")
            }
            .padding(.leading, 20)
            .padding()
        }
    }
}

#Preview {
    let mockViewModel = ViewModel(TripDataSource.test)
    return SimpleTripCardView(trip: mockViewModel.trips.first!)
}
