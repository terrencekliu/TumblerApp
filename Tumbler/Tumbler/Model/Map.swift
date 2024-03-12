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

    func toTransportation(_ mkTransportType: MKDirectionsTransportType) -> Transportation? {
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

    func toMKTransportType() -> MKDirectionsTransportType {
        switch self {
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

    func toReadableAppleMapsLink() -> String {
        switch self {
        case .car:
            return "d"
        case .transit:
            return "r"
        case .walk:
            return "w"
        case .cycle:
            return ""
        }
    }

    func toReadableGoogleMapsLink() -> String {
        switch self {
        case .car:
            return "driving"
        case .transit:
            return "transit"
        case .walk:
            return "walking"
        case .cycle:
            return "bicycling"
        }
    }
}

extension MKRoute {
    func formattedTravelTime() -> String {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .abbreviated
        formatter.allowedUnits = [.hour, .minute]
        return formatter.string(from: self.expectedTravelTime) ?? "nil"
    }

    func formattedTotalDistance() -> String {
        let formatter = MKDistanceFormatter()
        formatter.unitStyle = .abbreviated
        formatter.units = .imperial
        return formatter.string(fromDistance: self.distance)
    }

    func formattedLeaveTime(goal: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateFormat = .none
        return formatter.string(from: goal.advanced(by: -self.expectedTravelTime))
    }
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

    func fetchRoute(transportation: Transportation, to destination: Address) async -> MKRoute? {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: self.toCLLocationCoordinate2D()))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination.toCLLocationCoordinate2D()))
        request.transportType = transportation.toMKTransportType()

        let result = try? await MKDirections(request: request).calculate()
        return result?.routes.first
    }
}
