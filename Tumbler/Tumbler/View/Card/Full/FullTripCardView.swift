//
//  TripCardView.swift
//  Tumbler
//
//  Created by Terrence Liu on 10/15/23.
//

import SwiftUI

struct FullTripCardView: View {
    @State private var selected: String = ""
       
       private let selectionOptions = [ //This is the List of values we'll use
           "my first option",
           "my second option",
           "my third option"
       ]
       
       var body: some View {
           Picker("Picker Name", //This is the picker's title
                  selection: $selected, //This is the binding variable
                  content: {
               ForEach(selectionOptions, id: \.self) {
                   Text($0)
               }
           })
       }
}

#Preview {
    FullTripCardView()
}
