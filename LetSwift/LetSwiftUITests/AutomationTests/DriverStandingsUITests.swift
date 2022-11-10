//
//  DriverStandingsUITests.swift
//  LetSwiftUITests
//
//  Created by Piotr Torczynski on 09/11/2022.
//

import UITesting
import SwiftUI

final class DriverStandingsUITests: UITestCase {

    private struct Paths {
        static let currentStandings = "/api/f1/current/driverStandings.json"
        static let selectedDriverStandigns = "api/f1/2022/drivers/max_verstappen/status.json?"
    }

    override func setUp() {
        // Stub the swifter server with relevant starting JSON returns

        server.addJSONStub(url: Paths.currentStandings, filename: "CurrentDriverStandings", method: .GET)
        server.addJSONStub(url: Paths.selectedDriverStandigns, filename: "DriverStandings", method: .GET)
        // Finish configuration and start the test app
        super.setUp()
    }

    func testSelectingDriverDetails() {
        app.staticTexts["Drivers Standings"]
            .wait(until: \.exists)

        app.staticTexts["Max Verstappen"]
            .wait(until: \.exists)

        // Assert drivers displayed
        // Tap row 1
        app.staticTexts["driver_row"]
            .firstMatch.wait(until: \.exists)
            .wait(until: \.isHittable)
            .tap()

        app.staticTexts["driver_status_attendance_view"]
            .wait(until: \.exists)
    }
}
