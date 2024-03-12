//
//  FullDayViewModel.swift
//  Tumbler
//
//  Created by Terrence Liu on 3/11/24.
//

import Foundation

@Observable
class FullDayViewModel: ObservableObject {
    var currentAddress: Address
    var nextAddress: Address
    var nextTime: Date?

    var transitTime: String = "--"
    var transportDistance: String = "--"
    var destinationDistance: String = "--"
    var destinationTime: String = "--"

    init(currentAddress: Address, nextAddress: Address, nextTime: Date? = nil) {
        self.currentAddress = currentAddress
        self.nextAddress = nextAddress
        self.nextTime = nextTime
    }
}
