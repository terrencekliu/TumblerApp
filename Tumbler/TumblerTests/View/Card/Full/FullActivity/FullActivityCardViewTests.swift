//
//  FullActivityCardViewTests.swift
//  TumblerTests
//
//  Created by Terrence Liu on 11/28/23.
//

import XCTest

@testable import Tumbler

final class FullActivityCardViewTests: XCTestCase {
    var testViewModel: FullActivityViewModel!

    let testActivity = Activity(
        id: "test-id",
        name: "Coffee House",
        type: Activity.ActivityType.food,
        address: "12345 SE 12th St Bellevue, WA 98006",
        quickInfo: ["Starting": "10:18 am", "Latte": "$5", "Ice Cream": "$6"],
        alert: "Car break-in common"
    )

    override func setUpWithError() throws {
        try super.setUpWithError()
        testViewModel = FullActivityViewModel(activity: testActivity)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        testViewModel = nil
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. 
        // Check the results with assertions afterwards.
    }

}
