//
//  FullDayViewModel.swift
//  Tumbler
//
//  Created by Terrence Liu on 3/11/24.
//

import Foundation
import SwiftUI

class FullDayViewModel: ObservableObject {
    @Published var currentAddress: Address
    @Published var nextAddress: Address
    @Published var nextTime: Date?

    @Published var transitTime: String = "--"
    @Published var transportDistance: String = "--"
    @Published var destinationDistance: String = "--"
    @Published var destinationTime: String = "--"

    init(currentAddress: Address, nextAddress: Address, nextTime: Date? = nil) {
        self.currentAddress = currentAddress
        self.nextAddress = nextAddress
        self.nextTime = nextTime
    }
}
