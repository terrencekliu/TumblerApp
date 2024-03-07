//
//  TripCardView.swift
//  Tumbler
//
//  Created by Terrence Liu on 10/15/23.
//

import SwiftUI

struct FullTripCardView: View {
    var arr = [1,2,3,4,5,6,7,8,9]
    @State private var selected: Int?

    var body: some View {
        List {
            ForEach(arr, id: \.self) { day in
                Text("\(day)")
            }
            .swipeActions {
                
            }
        }
        .scrollContentBackground(.visible)
        .environment(\.editMode, .constant(.active))
    }
}

#Preview {
    FullTripCardView()
}
