//
//  LetSwiftSnapshotTestCase.swift
//  LetSwiftSnapshotTests
//
//  Created by Piotr Torczynski on 06/11/2022.
//

@testable import Testing

class LetSwiftSnapshotTestCase: TestCase, SnapshotTestCase {
    override func setUp() {
        super.setUp()

        setUpSnapshotTests()
    }

    override func tearDown() {
        tearDownSnapshotTests()

        super.tearDown()
    }
}
