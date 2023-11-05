//
//  Trip.swift
//  Tumbler
//
//  Created by Terrence Liu on 10/16/23.
//

import Foundation

struct Trip: Identifiable {
    let id: String

    var name: String
    var days: [Day]
}
