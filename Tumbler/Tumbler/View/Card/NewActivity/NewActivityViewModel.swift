//
//  NewActivityViewModel.swift
//  Tumbler
//
//  Created by Terrence Liu on 12/23/23.
//

import Foundation
import SwiftData
import CoreLocation
import PhotosUI
import _PhotosUI_SwiftUI
import PDFKit

extension NewActivityViewModel {
    enum Error: LocalizedError {
        case noSuchAddress

        var errorDescription: String? {
            switch self {
            case .noSuchAddress: return "Invalid Address"
            }
        }

        var recoverySuggestion: String? {
            switch self {
            case .noSuchAddress: return "Please enter a valid address."
            }
        }
    }
}

@Observable
class NewActivityViewModel: ObservableObject {
    @ObservationIgnored private let dataSource: TripDataSource
    var form = NewActivityForm()

    init(dataSource: TripDataSource = TripDataSource.shared) {
        self.dataSource = dataSource
    }

    func addActivity(trip: Trip) throws {
        setCoordinate { coordinate, error in
            if error == nil {
                self.form.latitude = coordinate.latitude
                self.form.longitude = coordinate.longitude
            }
        }

        if self.form.latitude == nil || self.form.longitude == nil {
            throw Error.noSuchAddress
        }

        let newAddress = Address(
            label: form.addressLabel,
            address: form.address,
            latitude: form.latitude!,
            longitude: form.longitude!
        )

        let newActivity = Activity(
            name: form.name,
            type: form.type,
            address: newAddress,
            defaultTransportation: form.defaultTransportation,
            thumbnail: form.thumbnail,
            ticketReserve: form.ticketReserve,
            files: form.files,
            quickInfo: form.quickInfo,
            alert: form.alert,
            notes: form.notes
        )
        trip.activities.append(newActivity)
        updateSource(activity: newActivity)
    }

    func convertItemToData(_ selectedPhotoItem: PhotosPickerItem?) {
        Task {
            if let imageData = try? await selectedPhotoItem?.loadTransferable(type: Data.self) {
                self.form.thumbnail = imageData
            }
        }
    }

    func handlePickedPDF(url: URL) {
        let pdfController: PDFDocument? = PDFDocument(url: url)
        if pdfController != nil {
            self.form.ticketReserve = pdfController!.dataRepresentation()
        } else {
          // TODO: Throw error
            print("URL is invalid")
        }
    }

    private func updateSource(activity: Activity) {
        dataSource.newActivity(activity)
        // update implicit from newActivity
    }

    private func setCoordinate(completionHandler: @escaping(CLLocationCoordinate2D, NSError?) -> Void ) {
        let getcoder = CLGeocoder()
        getcoder.geocodeAddressString(self.form.address) { (placemarks, error) in
            if error == nil {
                if let placemark = placemarks?[0] {
                    let location = placemark.location!
                    completionHandler(location.coordinate, nil)
                    return
                }
            }
            completionHandler(kCLLocationCoordinate2DInvalid, error as NSError?)
        }
    }
}
