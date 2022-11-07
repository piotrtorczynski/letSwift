//
//  TestCase.swift
//  Testing
//
//  Created by Piotr Torczynski on 01/11/2022.
//

import Foundation
import XCTest

public enum TestError: Error {
    case none
    case generic(String)
}

open class TestCase: XCTestCase {
    public static let timeoutDuration: TimeInterval = 5.0

    // MARK: - XCTestExpectation Helpers

    /// Convenience method that uses the default timeoutDuration
    public func wait(for expectations: [XCTestExpectation]) {
        wait(for: expectations, timeout: TestCase.timeoutDuration)
    }

    /// Convenience method that simplifies asynchronous expectation implementation
    /// It creates expectation and fulfills it asynchronously
    public func waitForAsyncAction(_ action: () -> Void) {
        let exp = expectation(description: "async action completed")

        action()

        DispatchQueue.main.async {
            exp.fulfill()
        }

        wait(for: [exp])
    }
}
