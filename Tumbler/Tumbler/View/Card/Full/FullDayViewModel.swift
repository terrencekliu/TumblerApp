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

    func mapLink(_ type: Transportation) -> String {
        // TODO: Add user saved map preferences
        return true ? appleMapsLink(type) : googleMapsLink(type)
    }

    private func appleMapsLink(_ transportation: Transportation) -> String {
        return """
        maps://?\
        saddr=\(currentAddress.latitude),\(currentAddress.longitude)&\
        daddr=\(nextAddress.latitude),\(nextAddress.longitude)&\
        dirflg=\(transportation.toReadableAppleMapsLink())
        """
    }

    private func googleMapsLink(_ transportation: Transportation) -> String {
        return """
        comgooglemaps://?\
        saddr=\(currentAddress.latitude),\(currentAddress.longitude)&\
        daddr=\(nextAddress.latitude),\(nextAddress.longitude)&\
        directionsmode=\(transportation.toReadableGoogleMapsLink())
        """
    }

    init(currentAddress: Address, nextAddress: Address, nextTime: Date? = nil) {
        self.currentAddress = currentAddress
        self.nextAddress = nextAddress
        self.nextTime = nextTime
    }
}
