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

    // MARK: - Open Properties

    /// Determines if `UITestCase` should handle login automatically before each UI test run.
    ///
    /// Defaults to `true`, but can be set to `false` if a UI test wants to handle login logic themselves perhaps to test LoginView
    /// or stub a different account response.
    open var autoLogin: Bool {
        return true
    }

    /// When `autoLogin` is `true`, this determines if a UI test will begin running while logged in or logged out.
    /// When `autoLogin` is `false` this simply lets `UITestCase` know if your UI test will manually login for clean-up purposes during `tearDown()`.
    ///
    /// Defaults to `false`, but should be overriden to `true` if your UI test will be logged in during its test runs.
    open var isLoggedIn: Bool {
        return false
    }

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

        // Stub account related API calls that happen on app launch
        if autoLogin {
            if isLoggedIn {
                // TODO: Update this logic eventually to support roles other than `Provider`
                server.addJSONStub(url: Paths.token, filename: "Token", method: .POST)
                server.addJSONStub(url: Paths.account, filename: "ProviderAccount", method: .GET)
            } else {
                server.addJSONStub(url: Paths.token, filename: "GuestToken", method: .POST)
                server.addJSONStub(url: Paths.account, filename: "GuestAccount", method: .GET)
            }
        }

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app.activate()
        app.launch()
    }

    override open func tearDown() {
        server.tearDown()

        super.tearDown()
    }

}

