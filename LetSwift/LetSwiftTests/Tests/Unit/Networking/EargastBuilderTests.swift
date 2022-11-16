//
//  EargastBuilderTests.swift
//  LetSwiftTests
//
//  Created by Piotr Torczynski on 05/11/2022.
//

import Networking
import Testing
import XCTest

@testable import LetSwift

final class EargastBuilderTests: TestCase {
    func testBuilder() {
        let builder = EargastBuilder()

        XCTAssertEqual(builder.host, "ergast.com")
        XCTAssertEqual(builder.root, "api/f1")
        XCTAssertEqual(builder.scheme, .https)
        XCTAssertNil(builder.version)
    }
}
