//
//  NavigationManager.swift
//  Tumbler
//
//  Created by Terrence Liu on 3/3/24.
//

import Foundation
import SwiftUI

enum TripDestination: Hashable {
    case trip(trip: Trip)
    case newDay(trip: Trip, day: Day? = nil)
    case addActivity(form: NewDayViewModel)
    case detailedActivity(activities: [Activity])
    case fullActivityCard
    case fullDayCard(day: Day)
    case allDays(trip: Trip)

    static func == (lhs: TripDestination, rhs: TripDestination) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    func hash(into hasher: inout Hasher) {
        var hashValue: Int {
            switch self {
            case .trip: return 1
            case .newDay: return 2
            case .addActivity: return 3
            case .detailedActivity: return 4
            case .fullActivityCard: return 5
            case .fullDayCard: return 6
            case .allDays: return 7
            }
        }

        hasher.combine(hashValue)
    }
}

@Observable
final class NavigationManager {
    var path: NavigationPath = NavigationPath()

    func navigate(to destination: TripDestination) {
        self.path.append(destination)
    }

    func navigateBack() {
        self.path.removeLast()
    }

    func navigateToTrip() {
        self.path.removeLast(path.count - 1)
    }
}
