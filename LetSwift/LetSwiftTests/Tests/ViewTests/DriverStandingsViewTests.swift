//
//  DriverStandingsViewTests.swift
//  LetSwiftTests
//
//  Created by Piotr Torczynski on 10/11/2022.
//

import Combine
import Cuckoo
import Resolver
import Testing
import ViewInspector
import XCTest

@testable import LetSwift

final class DriverStandingsViewTests: TestCase {

    private let subject = PassthroughSubject<[DriverStandings], Error>()
    let viewFactoryMock = ViewFactory()

    override func setUp() {
        super.setUp()

        let mock = MockEargastAPIServiceProtocol()

        stub(mock) { mock in
            when(mock.getCurrentDriverStandings())
                .thenReturn(subject.eraseToAnyPublisher())
        }

        Resolver.register { mock }
            .implements(EargastAPIServiceProtocol.self)

        Resolver.register { self.viewFactoryMock }
            .implements(ViewVending.self)
            .scope(.application)
    }

    func testLoadingView() throws {
        let viewModel = DriverStandingsViewModel()
        viewModel.state = .loading

        let view = DriverStandingsView(viewModel: viewModel)

        ViewHosting.host(view: view)

        XCTAssertNotNil(try view.inspect().find(viewWithId: "circlural_view"))
    }

    func testErrorState() throws {
        let viewModel = DriverStandingsViewModel()

        let view = DriverStandingsView(viewModel: viewModel)

        ViewHosting.host(view: view)

        waitForAsyncAction {
            subject.send(completion: .failure(TestError.none))
        }

        XCTAssertNotNil(try view.inspect().find(viewWithId: "try_again_view"))
    }

    func testLoadedState() throws {
        let viewModel = DriverStandingsViewModel()

        let view = DriverStandingsView(viewModel: viewModel)

        ViewHosting.host(view: view)

        waitForAsyncAction {
            subject.send(PreviewStubs.Data.standings.data.standings.standingsLists.first!.driverStandings)
            subject.send(completion: .finished)
        }

        XCTAssertNotNil(try view.inspect().find(viewWithId: "driver_standings_list"))
    }
}

