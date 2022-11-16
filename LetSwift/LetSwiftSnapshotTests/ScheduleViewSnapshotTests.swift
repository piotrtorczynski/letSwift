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

    // Subject for API calls
    private let subject = PassthroughSubject<[Race], Error>()

    override func setUp() {
        super.setUp()

        // Create API service mock
        let mock = MockEargastAPIServiceProtocol()

        // Stub API with subject
        stub(mock) { mock in
            when(mock.getCurrentSchedule())
                .thenReturn(subject.eraseToAnyPublisher())
        }

        // Register mock as a depdendency
        Resolver.register { mock }
            .implements(EargastAPIServiceProtocol.self)
    }

    func testLoadingView() {
        // Creates view model and set certain state
        let viewModel = ScheduleViewModel()
        viewModel.state = .loading

        // Creates view with view model
        let view = ScheduleView(viewModel: viewModel)

        // Run snapshot assertion
        assertsSnapshots(matching: view)
    }

    func testLoadedView() {
        // Creates view model and set certain state
        let races = PreviewStubs.Data.races
        let viewModel = ScheduleViewModel()
        viewModel.state = .loaded

        viewModel.upcomingRaces = Array(races[0...4])
        viewModel.finishedRaces = Array(races[5...21])

        // Creates view with view model
        let view = ScheduleView(viewModel: viewModel)

        // Run snapshot assertion
        assertsSnapshots(matching: view)
    }

    func testLoadedFinishedView() {
        // Creates view model and set certain state
        let races = PreviewStubs.Data.races
        let viewModel = ScheduleViewModel()
        viewModel.state = .loaded

        viewModel.upcomingRaces = Array(races[0...4])
        viewModel.finishedRaces = Array(races[5...21])
        viewModel.selectedSegment = .finished

        // Creates view with view model
        let view = ScheduleView(viewModel: viewModel)

        // Run snapshot assertion
        assertsSnapshots(matching: view)
    }
}
