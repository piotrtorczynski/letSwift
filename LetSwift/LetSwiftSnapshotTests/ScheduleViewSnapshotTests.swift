//
//  ScheduleViewSnapshotTests.swift
//  LetSwiftSnapshotTests
//
//  Created by Piotr Torczynski on 01/11/2022.
//

import Combine
import Cuckoo
import Resolver
import SnapshotTesting
import Testing
import XCTest

@testable import LetSwift

final class ScheduleViewSnapshotTests: LetSwiftSnapshotTestCase {

    private let subject = PassthroughSubject<[Race], Error>()

    override func setUp() {
        super.setUp()

        let mock = MockEargastAPIServiceProtocol()

        stub(mock) { mock in
            when(mock.getCurrentSchedule())
                .thenReturn(subject.eraseToAnyPublisher())
        }

        Resolver.register { mock }
            .implements(EargastAPIServiceProtocol.self)
    }

    func testLoadingView() {
        let viewModel = ScheduleViewModel()
        viewModel.state = .loading

        let view = ScheduleView(viewModel: viewModel)
        assertsSnapshots(matching: view)
    }

    func testLoadedView() {
        let viewModel = ScheduleViewModel()
        viewModel.state = .loaded

        viewModel.upcomingRaces = Array(PreviewStubs.Data.races[0...4])
        viewModel.finishedRaces = Array(PreviewStubs.Data.races[5...21])

        let view = ScheduleView(viewModel: viewModel)
        assertsSnapshots(matching: view)
    }

    func testLoadedFinishedView() {
        let viewModel = ScheduleViewModel()
        viewModel.state = .loaded

        viewModel.upcomingRaces = Array(PreviewStubs.Data.races[0...4])
        viewModel.finishedRaces = Array(PreviewStubs.Data.races[5...21])
        viewModel.selectedSegment = .finished

        let view = ScheduleView(viewModel: viewModel)
        assertsSnapshots(matching: view)
    }
}
