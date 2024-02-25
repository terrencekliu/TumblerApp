//
//  MockData.swift
//  Tumbler
//
//  Created by Terrence Liu on 1/30/24.
//

import Foundation
private let tripId1 = UUID()
private let tripId2 = UUID()
private let dayId1 = UUID()
private let dayId2 = UUID()
private let dayId3 = UUID()
private let eventId1 = UUID()
private let eventId2 = UUID()
private let eventId3 = UUID()
private let eventId4 = UUID()
private let activityId1 = UUID()
private let activityId2 = UUID()
private let activityId3 = UUID()
private let activityId4 = UUID()

private let dateFormatter: (String) -> Date = { dateTime in
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
    return dateFormatter.date(from: dateTime)!
}

let testTrip1 = Trip(id: tripId1, name: "Test Trip 1", days: [testDay1], activities: [testActivity1, testActivity2, testActivity3, testActivity4])
let testTrip2 = Trip(id: tripId2, name: "Test Trip 2", days: [testDay2, testDay3], activities: [])

let testDay1 = Day(id: dayId1, name: "Test Day 1", startTime: dateFormatter("2024-01-01 00:00"), endTime: dateFormatter("2030-01-01 00:00"), events: [testEvent1, testEvent2])
let testDay2 = Day(id: dayId2, name: "Test Day 2", startTime: dateFormatter("2024-01-01 00:00"), endTime: dateFormatter("2030-01-01 00:00"), events: [testEvent3])
let testDay3 = Day(id: dayId3, name: "Test Day 3", startTime: dateFormatter("2024-01-01 00:00"), endTime: dateFormatter("2030-01-01 00:00"), events: [])

let testEvent3 = Event(id: eventId3, activities: [], startTime: dateFormatter("2024-01-01 01:00"), endTime: dateFormatter("2024-01-01 10:00"))
let testEvent4 = Event(id: eventId4, activities: [], startTime: dateFormatter("2024-01-01 01:00"), endTime: dateFormatter("2024-01-01 10:00"))

let testEvent1 = Event(id: eventId1, activities: [testActivity1, testActivity2], startTime: dateFormatter("2024-01-01 01:00"), endTime: dateFormatter("2024-01-01 10:00"))
let testEvent2 = Event(id: eventId2, activities: [testActivity3, testActivity4], startTime: dateFormatter("2024-01-01 15:00"), endTime: dateFormatter("2024-01-01 20:00"))

let testActivity1 = Activity(
    id: activityId1,
    name: "Coffee Shop",
    type: Activity.ActivityType.food,
    address: "12345 SE 12th St Bellevue, WA",
    quickInfo: [TupleModel("Starting", "10:18 am"), TupleModel("Latte", "$5"), TupleModel("Ice Cream", "$6")],
    alert: "Car break-in common",
    notes: """
    Nestled on the quaint corner of Elmwood Avenue, in the heart of a bustling town, lies Whispering Beans Café, a sanctuary for coffee connoisseurs and casual sippers alike. \
    As you step through the rustic, weathered wooden door, a warm, inviting aroma envelops you, a fragrant promise of the exquisite coffee journey that awaits.
    
    The interior of Whispering Beans is a masterful blend of contemporary chic and vintage charm. \
    Exposed brick walls adorned with local art provide a canvas for the dance of warm, muted lighting, casting a soft, welcoming glow on the patrons. \
    Weathered leather armchairs and plush couches beckon you to settle in, while polished oak tables offer a space to gather, work, or simply lose yourself in the pages of a good book. \
    Overhead, a symphony of mellow jazz notes mingles with the quiet hum of conversations, creating a backdrop that is both soothing and invigorating.
    
    Behind the sleek, mahogany-topped counter, a team of passionate baristas stand ready, each a maestro in the art of brewing. \
    With gleaming espresso machines and an array of freshly sourced beans, they craft each cup with precision and care, transforming the humble coffee bean into liquid poetry. \
    Their expertise is matched only by their genuine enthusiasm to share their knowledge and help patrons discover their perfect brew."
    """
)

let testActivity2 = Activity(
    id: activityId2,
    name: "City Bench",
    type: Activity.ActivityType.attraction,
    address: "12345 SE 12th St Bellevue, WA 98006",
    quickInfo: [TupleModel("Starting", "10:18 am"), TupleModel("Latte", "$5"), TupleModel("Ice Cream", "$6")],
    alert: "Car break-in common"
)

let testActivity3 = Activity(
    id: activityId3,
    name: "Walk of Rant",
    type: Activity.ActivityType.attraction,
    address: "12345 SE 12th St Bellevue, WA 98006",
    quickInfo: [TupleModel("Starting", "10:18 am"), TupleModel("Latte", "$5"), TupleModel("Ice Cream", "$6")],
    alert: "Car break-in common"
)

let testActivity4 = Activity(
    id: activityId4,
    name: "Solar Panel Exhibit",
    type: Activity.ActivityType.attraction,
    address: "12345 SE 12th St Bellevue, WA 98006",
    quickInfo: [TupleModel("Starting", "10:18 am"), TupleModel("Latte", "$5"), TupleModel("Ice Cream", "$6")],
    alert: "Car break-in common"
)

//let testTuple1 = ActivityEventGroup(
//    true,
//    Date(),
//    testActivity1
//)
//
//let testTuple2 = ActivityEventGroup(
//    false,
//    Date(),
//    testActivity2
//)
