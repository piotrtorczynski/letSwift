//
//  EargastBuilderTests.swift
//  LetSwiftTests
//
//  Created by Piotr Torczynski on 05/11/2022.
//

import Cuckoo
import Networking
import Resolver
import Testing
import XCTest

@testable import LetSwift

final class EargastBuilderTests: TestCase {

    override func setUp() {
        super.setUp()

        let mock = MockServerEnvironmentControllerProtocol()

        stub(mock) { mock in
            when(mock.environment.get).thenReturn(.production)
            when(mock.initialServerEnvironment.get).thenReturn(.production)
        }

        Resolver.register { mock }
            .implements(ServerEnvironmentControllerProtocol.self)
    }

    func testBuilder() {
        let builder = EargastBuilder()

        XCTAssertEqual(builder.host, "ergast.com")
        XCTAssertEqual(builder.root, "api/f1")
        XCTAssertEqual(builder.scheme, .https)
        XCTAssertNil(builder.version)
    }
}
