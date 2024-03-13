//
//  Activity.swift
//  Tumbler
//
//  Created by Terrence Liu on 10/16/23.
//

import Foundation
import SwiftData
import MapKit
import PDFKit

@Model
class Activity: Identifiable, ObservableObject {
    @Attribute(.unique) var id: UUID
    var event: Event?
    var trip: Trip?

    var name: String
    var type: ActivityType

    var address: Address
    var defaultTransportation: Transportation

    @Attribute(.externalStorage) var thumbnail: Data? // Convert to UIImage to display
    @Attribute(.externalStorage) var ticketReserve: Data?
    @Attribute(.externalStorage) var files: Data?

    var quickInfo: [TupleModel] = []

    var alert: String
    var notes: String

    enum ActivityType: String, CaseIterable, Identifiable, Codable {
        case beach
        case attraction
        case food
        case house
        case camp
        case other

        var id: Self { self }

        var symbol: ActivitySymbolName {
            switch self {
            case .beach:
                return ActivitySymbolName.beaches
            case .attraction:
                return ActivitySymbolName.attractions
            case .food:
                return ActivitySymbolName.foods
            case .house:
                return ActivitySymbolName.houses
            case .camp:
                return ActivitySymbolName.camps
            case .other:
                return ActivitySymbolName.others
            }
        }
    }

    init(
        id: UUID = UUID(),
        name: String,
        type: ActivityType = ActivityType.other,
        address: Address,
        defaultTransportation: Transportation = .car,
        thumbnail: Data? = nil,
        ticketReserve: Data? = nil,
        files: Data? = nil,
        quickInfo: [TupleModel],
        alert: String = "",
        notes: String = ""
    ) {
        self.id = id
        self.name = name
        self.type = type
        self.address = address
        self.defaultTransportation = defaultTransportation
        self.thumbnail = thumbnail
        self.ticketReserve = ticketReserve
        self.files = files
        self.quickInfo = quickInfo
        self.alert = alert
        self.notes = notes
    }

    func convertDataToImage() -> UIImage? {
        return self.thumbnail != nil ? UIImage(data: self.thumbnail!) : nil
    }

    func convertDataToPDF() -> PDFDocument? {
        if self.ticketReserve != nil {
            let pdfController: PDFDocument? = PDFDocument(data: self.ticketReserve!)
            return pdfController
        }
        return nil
    }
}
