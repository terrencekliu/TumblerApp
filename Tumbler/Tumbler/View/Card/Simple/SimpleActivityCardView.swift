//
//  SimpleTripCardView.swift
//  Tumbler
//
//  Created by Carol Liu on 11/4/23.
//

import SwiftUI

struct SimpleActivityCardView: View {
    @State var activityName: String
    var thumbnail: UIImage?

    var body: some View {
        ZStack(alignment: .topLeading) {
            
            if thumbnail == nil {
                Image("rectangleCafe")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .brightness(-0.2)
                    .accessibilityIdentifier("preview-image")
            } else {
                Image(uiImage: thumbnail!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 200, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .brightness(-0.2)
                    .accessibilityIdentifier("preview-image")
            }
            VStack(alignment: .leading) {
                Text(activityName)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
                    .accessibilityIdentifier("name-text")
            }
            .frame(maxWidth: 170, alignment: .leading)
            .padding()
        }
    }
}

#Preview {
    let mockViewModel = ViewModel(TripDataSource.test)
    return SimpleActivityCardView(activityName: mockViewModel.trips.first!.name)
}
