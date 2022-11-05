//
//  DriverStatusRequestTests.swift
//  LetSwiftTests
//
//  Created by Piotr Torczynski on 05/11/2022.
//

import Networking
import Testing
import XCTest

@testable import LetSwift

final class DriverStatusRequestTests: TestCase {
    func testRequest() {
        let request = DriverStatusRequest(driverId: "fixed_id")

        XCTAssertEqual(request.headers, [:])
        XCTAssertEqual(request.path, "2022/drivers/fixed_id/status.json")
        XCTAssertEqual(request.method, .get)
        XCTAssertFalse(request.requiresAuthorization)
    }
}
