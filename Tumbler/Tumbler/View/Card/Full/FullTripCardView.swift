//
//  TripCardView.swift
//  Tumbler
//
//  Created by Terrence Liu on 10/15/23.
//

import SwiftUI

private var testList = [1,2,3,4,5,6,7,8,9,10,11,1,1,1,1,1,1,1,1,1,1]

struct FullTripCardView: View {
    var body: some View {
        List {
            ForEach(testList, id: \.self) { number in
                Text("\(number)")
            }
        }
    }
}

#Preview {
    FullTripCardView()
}
