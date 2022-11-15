//
//  EargastAPIServiceTests.swift
//  LetSwiftTests
//
//  Created by Piotr Torczynski on 05/11/2022.
//

import Combine
import Cuckoo
import Networking
import Resolver
import Testing
import XCTest

@testable import LetSwift


/// A class to test API Service
final class EargastAPIServiceTests: TestCase {

    // MARK: - Properties
    private var cancellable: AnyCancellable?

    // MARK: - Mocks
    private let apiClient = MockAPIClient()

    // MARK: - Subject under tests

    private var sut: EargastAPIServiceProtocol!

    override func setUp() {
        super.setUp()

        // Register local dependency to container
        // EargastAPIService uses injected APIClient instance
        Resolver.register { self.apiClient }
            .implements(APIClient.self)

        sut = EargastAPIService()
    }

    func testgetVerifyIfRequestWasPerformed() {
        // Create a publisher to be returned by api client
        let driverStatusPublisher = PassthroughSubject<DriverStatusResponse, Error>()

        // Stub api client to return our publisher for certain request
        stub(apiClient) { mock in
            when(mock.perform(request: any(DriverStatusRequest.self), any()))
                .thenReturn(driverStatusPublisher.eraseToAnyPublisher())
        }

        // perform service call
        _ = sut.getDriverStatus(driverId: "fixed_id")

        // check if network client called function
        verify(apiClient, times(1)).perform(request: DriverStatusRequest(driverId: "fixed_id"), any())
    }

    func testGetCurrentDriverStandingsReturnsError() {
        // Create a publisher to be returned by api client
        let driverStandingsPublisher = PassthroughSubject<CurrentSeasonRequest.ReturnType, Error>()

        // Stub api client to return our publisher for certain request
        stub(apiClient) { mock in
            when(mock.perform(request: any(CurrentSeasonRequest.self), any()))
                .thenReturn(driverStandingsPublisher.eraseToAnyPublisher())
        }

        // Subscribe for service call to get the details
        cancellable = sut.getCurrentDriverStandings()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    if let testError = error as? TestError {
                        // Desire assertion
                        XCTAssertEqual(testError, TestError.none)
                    } else {
                        XCTFail("Wrong error")
                    }
                default:
                    XCTFail("Expected failure instead of success")
                }
            } receiveValue: { _ in
                XCTFail("Test should not send value")
            }

        // Use helper to use publisher
        waitForAsyncAction {
            driverStandingsPublisher.send(completion: .failure(TestError.none))
        }
    }

    func testGetCurrentDriverStandingsReturnsValue() {
        // Create a publisher to be returned by api client
        let driverStandingsPublisher = PassthroughSubject<CurrentDriverStandings, Error>()

        // Stub api client to return our publisher for certain request
        stub(apiClient) { mock in
            when(mock.perform(request: any(CurrentSeasonRequest.self), any()))
                .thenReturn(driverStandingsPublisher.eraseToAnyPublisher())
        }

        // Subscribe for service call to get the details
        cancellable = sut.getCurrentDriverStandings()
            .sink { _ in
            } receiveValue: { value in
                XCTAssertEqual(value.count, 22)
            }

        // Use helper to use publisher
        waitForAsyncAction {
            driverStandingsPublisher.send(PreviewStubs.Data.standings)
            driverStandingsPublisher.send(completion: .finished)
        }
    }
}


extension DriverStatusRequest: Matchable {
    /// Extend Cuckoo to be able to work with custom type
    public var matcher: ParameterMatcher<DriverStatusRequest> {
        ParameterMatcher<DriverStatusRequest>()
    }
}
