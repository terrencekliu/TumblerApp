//
//  AddActivityViewModel.swift
//  Tumbler
//
//  Created by Vincent Liu on 2/13/24.
//

import Foundation
import SwiftData

@Observable
class AddActivityViewModel: ObservableObject {
    @ObservationIgnored private let dataSource: TripDataSource

    init(dataSource: TripDataSource = TripDataSource.shared) {
        self.dataSource = dataSource
    }
}
