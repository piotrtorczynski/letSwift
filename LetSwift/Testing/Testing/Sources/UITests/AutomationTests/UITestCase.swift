//
//  UITestCase.swift
//  Testing
//
//  Created by Piotr Torczynski on 01/11/2022.
//

import Core
import SwiftUI
import XCTest

/// Base class for UI tests.
///
/// Sets up our mock server, environment variables, and launch arguments necessary for UI tests to run successfully. Launches the app before each test run.
open class UITestCase: XCTestCase {

    struct Paths {
        static let token = "/oauth/token"
        static let account = "/api/v2/account"
    }

    // MARK: - Properties

    /// Swifter HTTP server for mocking network traffic during UI test runs.
    public let server = MockServer()

    /// A proxy that can launch, monitor, and terminate a test application.
    public var app: XCUIApplication!

    /// A proxy for monitoring the springboard.
    ///
    /// Useful for interacting with system alerts or other UI elements that live outside our application.
    public var springboard: XCUIApplication!

    /// The bundle where mock response files are contained
    public static let bundle = Bundle(identifier: "com.smartapps.LetSwiftUITests")

    // MARK: - XCTestCase

    override open func setUp() {
        super.setUp()

        server.setUp()

        // Setup the app for ui testing against localhost
        app = XCUIApplication()
        springboard = XCUIApplication(bundleIdentifier: "com.apple.springboard")
        app.launchArguments.append("isUITesting")
        if let port = server.port {
            app.launchArguments.append("--port:\(port)")
        }

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app.activate()
        app.launch()
    }

    override open func tearDown() {
        server.tearDown()

        super.tearDown()
    }
}

