//
//  NewActivityViewModel.swift
//  Tumbler
//
//  Created by Terrence Liu on 12/23/23.
//

import Foundation
import SwiftData
import CoreLocation

@Observable
class NewActivityViewModel: ObservableObject {
    @ObservationIgnored private let dataSource: TripDataSource
    var form = NewActivityForm()

    init(dataSource: TripDataSource = TripDataSource.shared) {
        self.dataSource = dataSource
    }

    // TODO: Add error handling for setCoordinate
    func addActivity(trip: Trip) {
        setCoordinate { coordinate, error in
            if error == nil {
                self.form.latitude = coordinate.latitude
                self.form.longitude = coordinate.longitude
                print("Valid Address")
            } else {
                print("Invalid Address")
            }
        }
        // TODO: Add validation
        let newAddress = Address(
            label: form.addressLabel,
            address: form.address,
            latitude: form.latitude!,
            longitude: form.longitude!)

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
