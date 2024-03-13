//
//  Extensions.swift
//  Tumbler
//
//  Created by Terrence Liu on 1/28/24.
//

import Foundation
import SwiftUI
import PDFKit

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

    func format() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        return formatter.string(from: self)
    }
}

extension Trip {
    func formatTripDuration() -> String {
        let days = getSortedDays()
        if days.count < 2 {
            return ""
        }

        let formatter = DateFormatter()
        let firstDay: Day = days.first!
        let lastDay: Day = days.last!
        let calendar = Calendar.current

        let firstDayMonth = calendar.component(.month, from: firstDay.startTime)
        let lastDayMonth = calendar.component(.month, from: lastDay.startTime)
        let firstYear = calendar.component(.year, from: firstDay.startTime)
        let lastYear = calendar.component(.year, from: lastDay.startTime)

        formatter.dateFormat = "MMM d"
        let firstDayString: String = formatter.string(from: firstDay.startTime)
        if firstDayMonth == lastDayMonth && firstYear == lastYear {
            formatter.dateFormat = "d"
        }
        let lastDayString: String = formatter.string(from: lastDay.startTime)

        formatter.dateFormat = "yyyy"

        // Process whether year will display for both start and end day
        let firstYearString: String = formatter.string(from: firstDay.startTime)
        let lastYearString: String = formatter.string(from: lastDay.startTime)
        if firstYear == lastYear {
            return "\(firstDayString) - \(lastDayString), \(lastYearString)"
        }

        return "\(firstDayString), \(firstYearString) - \(lastDayString), \(lastYearString)"
    }
}

extension Event {
    func getStartTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm"
        return formatter.string(from: self.startTime)
    }
}

extension Collection where Element: Comparable {
  func isSorted(by areInAscendingOrder: (Element, Element) -> Bool) -> Bool {
    var previous: Element?
    for item in self {
      if let prev = previous {
        if !areInAscendingOrder(prev, item) {
          return false // not in order
        }
      }
      previous = item
    }
    return true // all elements are in order
  }
}

extension Data {
    func toPDFDocument() -> PDFDocument? {
        return PDFDocument(data: self)
    }
    
    func toUImage() -> UIImage? {
        return UIImage(data: self)
    }
}
