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

    // MARK: - Subject for API
    private let publisher = PassthroughSubject<[DriverStandings], Error>()

    // MARK: - Mocks
    private let viewFactoryMock = ViewFactory()

    override func setUp() {
        super.setUp()

        // Create mock
        let mock = MockEargastAPIServiceProtocol()

        // Stub service call and return subject
        stub(mock) { mock in
            when(mock.getCurrentDriverStandings())
                .thenReturn(publisher.eraseToAnyPublisher())
            when(mock.getDriverStatus(driverId: any()))
                .thenReturn(PassthroughSubject<DriverStatus, Error>().eraseToAnyPublisher())
        }

        // Register mocks as dependencies
        Resolver.register { mock }
            .implements(EargastAPIServiceProtocol.self)

        Resolver.register { self.viewFactoryMock }
            .implements(ViewVending.self)
    }

    func testLoadingView() throws {
        // Create view model and set state
        let viewModel = DriverStandingsViewModel()

        // Create view
        let view = DriverStandingsView(viewModel: viewModel)

        // Host view to call view lifecycle methods
        ViewHosting.host(view: view)

        // Assert if some parts of view are visible
        XCTAssertNotNil(try view.inspect().find(viewWithId: "circlural_view"))
    }

    func testErrorState() throws {
        // Create view model and set state
        let viewModel = DriverStandingsViewModel()

        // Create view
        let view = DriverStandingsView(viewModel: viewModel)

        // Host view to call view lifecycle methods
        ViewHosting.host(view: view)

        // send api call results
        waitForAsyncAction {
            publisher.send(completion: .failure(TestError.none))
        }

        // Assert view elements
        XCTAssertNotNil(try view.inspect().find(viewWithId: "try_again_view"))
    }

    func testLoadedState() throws {
        // Create view model and set state
        let viewModel = DriverStandingsViewModel()

        // Create view
        let view = DriverStandingsView(viewModel: viewModel)

        // Host view to call view lifecycle methods
        ViewHosting.host(view: view)

        // Send success api call results
        waitForAsyncAction {
            publisher.send(PreviewStubs.Data.standings.data.standings.standingsLists.first!.driverStandings)
            publisher.send(completion: .finished)
        }

        // Assert view elements
        XCTAssertNotNil(try view.inspect().find(viewWithId: "driver_standings_list"))
    }

    func testNavigationToDetails() throws {
        // Create view model and set state
        let viewModel = DriverStandingsViewModel()

        // Create view
        let view = DriverStandingsView(viewModel: viewModel)

        // Host view to call view lifecycle methods
        ViewHosting.host(view: view)

        // Send success api call results
        waitForAsyncAction {
            publisher.send(PreviewStubs.Data.standings.data.standings.standingsLists.first!.driverStandings)
            publisher.send(completion: .finished)
        }
        
        // Assert view elements
        XCTAssertNotNil(try view.inspect().find(viewWithId: "driver_standings_list"))

        // Find all lists elements of DriverRow view
        let driverRows = try view.inspect().findAll(DriverRow.self)
        let firstDriver = driverRows[0]

        XCTAssertEqual(try firstDriver.find(viewWithId: "driver_name").text().string(), "Max Verstappen")

        // Try to tap button on driver row
        try firstDriver.find(viewWithId: "button").button().tap()

        // Verify navigation destination
        switch viewModel.destination {
        case .driverStatus(let driver):
            XCTAssertEqual(driver.driverId, "max_verstappen")
        default:
            XCTFail("Wrong destination")
        }
    }
}
