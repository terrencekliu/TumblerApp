//
//  File.swift
//  Tumbler
//
//  Created by Terrence Liu on 1/30/24.
//

import Foundation
private let tripId1 = UUID()
private let eventId1 = UUID()
private let eventId2 = UUID()
private let activityId1 = UUID()
private let activityId2 = UUID()
private let activityId3 = UUID()
private let activityId4 = UUID()

let testTrip1 = Trip(name: "Test Trip", days: [testDay1], activities: [testActivity1, testActivity2, testActivity3, testActivity4])

let testDay1 = Day(name: "Test Day", startTime: Date(), endTime: Date(), events: [testEvent1, testEvent2])

let testEvent1 = Event(activities: [testActivity1, testActivity2], startTime: Date.now, endTime: Date.now)
let testEvent2 = Event(activities: [testActivity3, testActivity4], startTime: Date.now, endTime: Date.now)

let testActivity1 = Activity(
    id: activityId1,
    name: "Coffee Shop",
    type: Activity.ActivityType.food,
    address: "12345 SE 12th St Bellevue, WA",
    quickInfo: ["Starting": "10:18 am", "Latte": "$5", "Ice Cream": "$6"],
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
    quickInfo: ["Starting": "10:18 am", "Latte": "$5", "Ice Cream": "$6"],
    alert: "Car break-in common"
)

let testActivity3 = Activity(
    id: activityId3,
    name: "Walk of Rant",
    type: Activity.ActivityType.attraction,
    address: "12345 SE 12th St Bellevue, WA 98006",
    quickInfo: ["Starting": "10:18 am", "Latte": "$5", "Ice Cream": "$6"],
    alert: "Car break-in common"
)

let testActivity4 = Activity(
    id: activityId4,
    name: "Solar Panel Exhibit",
    type: Activity.ActivityType.attraction,
    address: "12345 SE 12th St Bellevue, WA 98006",
    quickInfo: ["Starting": "10:18 am", "Latte": "$5", "Ice Cream": "$6"],
    alert: "Car break-in common"
)
