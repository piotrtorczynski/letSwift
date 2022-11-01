//
//  XCUIelementExtensions.swift
//  Testing
//
//  Created by Piotr Torczynski on 01/11/2022.
//

import Foundation
import XCTest

public extension XCUIElement {

    // Many elements in a SwiftUI app have no tap() func, but have touch events associated with them
    // If an element is not hittable, this extension taps the element's co-ordinates instead
    func forceTapElement() {
        if self.isHittable {
            self.tap()
        } else {
            let coordinate: XCUICoordinate = self.coordinate(withNormalizedOffset: CGVector(dx: 0.0, dy: 0.0))
            coordinate.tap()
        }
    }

    @discardableResult
    func waitForExistence(timeout: UITestTimeout = .standard) -> Bool {
        return waitForExistence(timeout: timeout.rawValue)
    }

    @discardableResult
    func waitForElementToBecomeHittable(timeout: UITestTimeout = .standard) -> Bool {
        return waitForExistence(timeout: timeout.rawValue) && isHittable
    }
}

/// XCUIElement helpers that leverage XCTWaiter APIs for faster checks.
/// Source: https://sourcediving.com/clean-waiting-in-xcuitest-43bab495230f
public extension XCUIElement {
    /// Explicitly wait until either `expression` evaluates to `true` or the `timeout` expires.
    ///
    /// If the condition fails to evaluate before the timeout expires, a failure will be recorded.
    ///
    /// **Example Usage:**
    ///
    /// ```
    /// element.wait(until: { !$0.exists })
    /// element.wait(until: { _ in otherElement.isEnabled }, timeout: .long)
    /// ```
    ///
    /// - Parameters:
    ///   - expression: The expression that should be evaluated before the timeout expires.
    ///   - timeout: The specificied amount of time to check for the given condition to match the expected value.
    ///   - message: An optional description of a failure.
    /// - Returns: The XCUIElement.
    @discardableResult
    func wait(
        until expression: @escaping (XCUIElement) -> Bool,
        timeout: UITestTimeout = .standard,
        message: @autoclosure () -> String = "",
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        if expression(self) {
            return self
        }

        let predicate = NSPredicate { _, _ in
            expression(self)
        }

        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: nil)
        let result = XCTWaiter().wait(for: [expectation], timeout: timeout.rawValue)
        if result != .completed {
            XCTFail(
                message().isEmpty ? "expectation not matched after waiting" : message(),
                file: file,
                line: line
            )
        }

        return self
    }

    /// Explicitly wait until the value of the given `keyPath` equates to `match`.
    ///
    /// If the `keyPath` fails to match before the timeout expires, a failure will be recorded.
    ///
    /// **Example Usage:**
    ///
    /// ```
    /// element.wait(until: \.isEnabled, matches: false)
    /// element.wait(until: \.label, matches: "Downloading...", timeout: .short)
    /// ```
    ///
    /// - Parameters:
    ///   - keyPath: A key path to the property of the receiver that should be evaluated.
    ///   - match: The value that the receivers key path should equal.
    ///   - timeout: The specificied amount of time to check for the given condition to match the expected value.
    ///   - message: An optional description of a failure.
    /// - Returns: The XCUIElement.
    @discardableResult
    func wait<Value: Equatable>(
        until keyPath: KeyPath<XCUIElement, Value>,
        matches match: Value,
        timeout: UITestTimeout = .standard,
        message: @autoclosure () -> String = "",
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        wait(
            until: { $0[keyPath: keyPath] == match },
            timeout: timeout,
            message: message(),
            file: file,
            line: line
        )
    }

    /// Explicitly wait until the value of the value of the given `keyPath` equals `true`.
    ///
    /// If the `keyPath` fails to match before the timeout expires, a failure will be recorded.
    ///
    /// **Example Usage:**
    ///
    /// ```
    /// element.wait(until: \.exists)
    /// element.wait(until: \.exists, timeout: .long)
    /// ```
    ///
    /// - Parameters:
    ///   - keyPath: The KeyPath that represents which property of the receiver should be evaluated.
    ///   - timeout: The specificied amount of time to check for the given condition to match the expected value.
    ///   - message: An optional description of a failure.
    /// - Returns: The XCUIElement.
    @discardableResult
    func wait(
        until keyPath: KeyPath<XCUIElement, Bool>,
        timeout: UITestTimeout = .standard,
        message: @autoclosure () -> String = "",
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        wait(
            until: keyPath,
            matches: true,
            timeout: timeout,
            message: message(),
            file: file,
            line: line
        )
    }

    /// Explicitly wait until the value of the given `keyPath` does not equate to `match`.
    ///
    /// If the `keyPath` fails to not match before the timeout expires, a failure will be recorded.
    ///
    /// **Example Usage:**
    ///
    /// ```
    /// element.wait(until: \.isEnabled, doesNotMatch: false)
    /// element.wait(until: \.label, doesNotMatch: "Downloading...", timeout: .short)
    /// ```
    ///
    /// - Parameters:
    ///   - keyPath: A key path to the property of the receiver that should be evaluated.
    ///   - match: The value that the receivers key path should not equal.
    ///   - timeout: The specificied amount of time to check for the given condition to match the expected value.
    ///   - message: An optional description of a failure.
    /// - Returns: The XCUIElement.
    @discardableResult
    func wait<Value: Equatable>(
        until keyPath: KeyPath<XCUIElement, Value>,
        doesNotMatch match: Value,
        timeout: UITestTimeout = .standard,
        message: @autoclosure () -> String = "",
        file: StaticString = #file,
        line: UInt = #line
    ) -> Self {
        wait(
            until: { $0[keyPath: keyPath] != match },
            timeout: timeout,
            message: message(),
            file: file,
            line: line
        )
    }
}
