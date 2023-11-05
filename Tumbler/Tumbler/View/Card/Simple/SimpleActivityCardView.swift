//
//  SimpleTripCardView.swift
//  Tumbler
//
//  Created by Carol Liu on 11/4/23.
//

import SwiftUI

struct SimpleTripCardView: View {

    var body: some View {
        ZStack(alignment: .topLeading) {

            Image("rectangleCafe")
                .resizable()
                .scaledToFill()
                .frame(width: 350, height: 199)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .brightness(-0.2)
            VStack(alignment: .leading) {
                Text("Barcelona")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                Text("Feb 6 - 12, 2020")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.white)
            } .padding()
        }
    }
}

#Preview {
    SimpleTripCardView()
}
