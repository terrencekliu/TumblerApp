//
//  TripCardView.swift
//  Tumbler
//
//  Created by Terrence Liu on 10/15/23.
//

import SwiftUI

struct FullTripCardView: View {
    @State var quickInfo = [("Hello", "Hello")]
    
    var body: some View {
        List {
            // TODO: Need quickInfo to be an EnviormentObject (editable)
            ForEach(quickInfo, id: \.0) { info in
                HStack {
                    Text(info.0)
                    Text(info.1)
                }
            } .onDelete { indexSet in
                quickInfo.remove(atOffsets: indexSet)
            } .onMove {
                quickInfo.move(fromOffsets: $0, toOffset: $1)
            }
        }
        .scrollContentBackground(.visible)
        .environment(\.editMode, .constant(.active))
    }
}

#Preview {
    FullTripCardView()
}
