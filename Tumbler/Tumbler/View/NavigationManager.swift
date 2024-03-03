//
//  NavigationManager.swift
//  Tumbler
//
//  Created by Terrence Liu on 3/3/24.
//

import Foundation
import SwiftUI

enum TripTabNavigation {
    case root, trip, newDay, addActivity, detailedActivity, fullActivityCard, fullDayCard
}

@Observable
class NavigationManager {
    var path: NavigationPath
    
    init(_ name: TripTabNavigation) {
        self.path = NavigationPath()
//        self.appendPath(name)
    }

    func appendPath(_ name: TripTabNavigation) {
        self.path.append(name)
    }

    func toRoot() {
        self.path.removeLast(path.count - 1)
    }
}
