//
//  ScheduleViewModelTests.swift
//  LetSwiftTests
//
//  Created by Piotr Torczynski on 06/11/2022.
//

import Combine
import Cuckoo
import Resolver
import Testing
import XCTest

@testable import LetSwift

final class ScheduleViewModelTests: TestCase {

    private let racesPublisher = PassthroughSubject<[Race], Error>()
    private let driverPublisher = PassthroughSubject<DriverStatus, Error>()

    var sut: ScheduleViewModel!

    override func setUp() {
        super.setUp()

        let serviceMock = MockEargastAPIServiceProtocol()

        stub(serviceMock) { mock in
            when(mock.getCurrentSchedule())
                .thenReturn(racesPublisher.eraseToAnyPublisher())
            when(mock.getDriverStatus(driverId: any()))
                .thenReturn(driverPublisher.eraseToAnyPublisher())
        }

        Resolver.register { serviceMock }
            .implements(EargastAPIServiceProtocol.self)

        sut = ScheduleViewModel()
    }

    func testGettingSchedule() {
        XCTAssertEqual(sut.finishedRaces.count, 0)
        XCTAssertEqual(sut.upcomingRaces.count, 0)

        sut.getSchedule()

        waitForAsyncAction {
            racesPublisher.send(PreviewStubs.Data.races)
            racesPublisher.send(completion: .finished)
        }

        XCTAssertEqual(sut.finishedRaces.count, 21)
        XCTAssertEqual(sut.upcomingRaces.count, 1)
    }

    func testFailingSchedule() {

        XCTAssertEqual(sut.finishedRaces.count, 0)
        XCTAssertEqual(sut.upcomingRaces.count, 0)

        sut.getSchedule()

        waitForAsyncAction {
            racesPublisher.send(completion: .failure(TestError.generic("fixed_reason")))
        }

        XCTAssertEqual(sut.finishedRaces.count, 0)
        XCTAssertEqual(sut.upcomingRaces.count, 0)

        switch sut.state {
        case .error(let error):
            if case TestError.generic(let reason) = error {
                XCTAssertEqual(reason, "fixed_reason")
            } else {
                XCTFail("wrong state")
            }
        default:
            XCTFail("wrong state")
        }
    }
}
