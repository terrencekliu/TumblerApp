//
//  Address.swift
//  Tumbler
//
//  Created by Vincent Liu on 2/29/24.
//

import Foundation

import SwiftUI
import MapKit

enum Transportation: String, Codable {
    case transit
    case walk
    case car
    case cycle
}

struct Address: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var label: String
    var address: String
    var latitude: Double
    var longitude: Double

    func toCLLocationCoordinate2D() -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
    
    func fetchRouteTo(transportation: Transportation, to destination: Address) async -> MKRoute? {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: self.toCLLocationCoordinate2D()))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination.toCLLocationCoordinate2D()))
        request.transportType = convertTransportType(transportation)

        let result = try? await MKDirections(request: request).calculate()
        return result?.routes.first
    }

    func formattedTravelTime(travelTime: Double?) -> String? {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]
        return travelTime != nil ? formatter.string(from: travelTime!) : nil
    }

    private func convertTransportType(_ mkTransportType: MKDirectionsTransportType) -> Transportation? {
        switch mkTransportType {
        case .automobile:
            return .car
        case .transit:
            return .transit
        case .walking:
            return .walk
        case .any:
            return .cycle
        default:
            return nil
        }
    }
    
    private func convertTransportType(_ type: Transportation) -> MKDirectionsTransportType {
        switch type {
        case .car:
            return .automobile
        case .transit:
            return .transit
        case .walk:
            return .walking
        case .cycle:
            return .any
        }
    }
}
