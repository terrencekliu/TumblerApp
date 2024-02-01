//
//  Extensions.swift
//  Tumbler
//
//  Created by Terrence Liu on 1/28/24.
//

import Foundation

extension Date {
    func endOfDay() -> Date {
        let calendar = Calendar.current
        let nextDateAfterMidnight = calendar.nextDate(
            after: self,
            matching: DateComponents(hour: 0, minute: 0, second: 0),
            matchingPolicy: .nextTime
        )!

        return nextDateAfterMidnight.addingTimeInterval(-1)
    }
}

