//
//  File.swift
//  Tumbler
//
//  Created by Terrence Liu on 1/30/24.
//

import Foundation
var testTrips: [Trip] = [testTrip0, testTrip1, testTrip2]

let quickInfo: [(String, String)] = [("Starting", "10:18 am"), ("Latte", "$5"), ("Ice Cream", "$6")]
let testActivity = Activity(
    name: "Coffee Shop",
    type: Activity.ActivityType.food,
    address: "12345 SE 12th St Bellevue, WA",
    quickInfo: [:],
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
    """,
    trip: testTrip
)

let testEvent = Event(activities: [testActivity], startTime: Date.now, endTime: Date.now)

let cityBench = Activity(
    name: "City Bench",
    type: Activity.ActivityType.attraction,
    address: "12345 SE 12th St Bellevue, WA 98006",
    quickInfo: ["Starting": "10:18 am", "Latte": "$5", "Ice Cream": "$6"],
    alert: "Car break-in common",
    trip: testTrip
)

let rantWalk = Activity(
    name: "Walk of Rant",
    type: Activity.ActivityType.attraction,
    address: "12345 SE 12th St Bellevue, WA 98006",
    quickInfo: ["Starting": "10:18 am", "Latte": "$5", "Ice Cream": "$6"],
    alert: "Car break-in common",
    trip: testTrip
)

let solarPanel = Activity(
    name: "Solar Panel Exhibit",
    type: Activity.ActivityType.attraction,
    address: "12345 SE 12th St Bellevue, WA 98006",
    quickInfo: ["Starting": "10:18 am", "Latte": "$5", "Ice Cream": "$6"],
    alert: "Car break-in common",
    trip: testTrip
)

let eBike = Activity(
    name: "Electric Bike Experience",
    type: Activity.ActivityType.attraction,
    address: "12345 SE 12th St Bellevue, WA 98006",
    quickInfo: ["Starting": "10:18 am", "Latte": "$5", "Ice Cream": "$6"],
    alert: "Car break-in common",
    trip: testTrip
)

// Test activities for food
let kumNGO = Activity(
    name: "Kum-N-Go",
    type: Activity.ActivityType.food,
    address: "12345 SE 12th St Bellevue, WA 98006",
    quickInfo: ["Starting": "10:18 am", "Latte": "$5", "Ice Cream": "$6"],
    alert: "Car break-in common",
    trip: testTrip
)

let goldenArch = Activity(
    name: "McDonald's",
    type: Activity.ActivityType.food,
    address: "12345 SE 12th St Bellevue, WA 98006",
    quickInfo: ["Starting": "10:18 am", "Latte": "$5", "Ice Cream": "$6"],
    alert: "Car break-in common",
    trip: testTrip
)

let lidl = Activity(
    name: "Lidl",
    type: Activity.ActivityType.food,
    address: "12345 SE 12th St Bellevue, WA 98006",
    quickInfo: ["Starting": "10:18 am", "Latte": "$5", "Ice Cream": "$6"],
    alert: "Car break-in common",
    trip: testTrip
)

let pizza = Activity(
    name: "Pizza Looking Thingys",
    type: Activity.ActivityType.food,
    address: "12345 SE 12th St Bellevue, WA 98006",
    quickInfo: ["Starting": "10:18 am", "Latte": "$5", "Ice Cream": "$6"],
    alert: "Car break-in common",
    trip: testTrip
)

let dateNow = Date()
let sameMonth = Date(timeIntervalSinceNow: 604800)
let nextMonth = Date(timeIntervalSinceNow: 2629056)
let nextYear = Date(timeIntervalSinceNow: 31622400)

let testDaySameMonth = Day(
    name: "South Downtown",
    startTime: sameMonth,
    endTime: sameMonth,
    thumbnail: false,
    events: [testEvent, testEvent]
)

let testDayNextMonth = Day(
    name: "South Downtown",
    startTime: nextMonth,
    endTime: nextMonth,
    thumbnail: false,
    events: [testEvent, testEvent]
)

let testDayNextYear = Day(
    name: "South Downtown",
    startTime: nextYear,
    endTime: nextYear,
    thumbnail: false,
    events: [testEvent, testEvent]
)

let testDay2 = Day(
    name: "South Downtown",
    startTime: Date.distantFuture,
    endTime: Date.distantFuture,
    thumbnail: false,
    events: [testEvent, testEvent]
)

let days: [Day] = [testDay, testDayNextMonth]

let testDay = Day(
    name: "South Downtown",
    startTime: Date.now,
    endTime: Date.now,
    thumbnail: false,
    events: [testEvent, testEvent]
)

let testTrip = Trip(name: "Barcelona", days: days)
let testTrip0 = Trip(name: "Barcelona", days: days)
let testTrip1 = Trip(name: "Seattle", days: days)
let testTrip2 = Trip(name: "Canada", days: days)
