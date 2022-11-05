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

@testable import LetSwift

final class EargastAPIServiceTests: TestCase {
    private let apiClient = MockAPIClient()

    private let driverStatusPublisher = PassthroughSubject<DriverStatusRequest.ReturnType, Error>()

    private var sut: EargastAPIServiceProtocol!

    override func setUp() {
        super.setUp()

        setupDependencies()
        stubDependencies()

        sut = EargastAPIService()
    }

    func testgetDriverStatus() {
        _ = sut.getDriverStatus(driverId: "fixed_id")

        verify(apiClient, times(1)).perform(request: DriverStatusRequest(driverId: "fixed_id"), any())
    }
}

extension EargastAPIServiceTests {
    private func setupDependencies() {
        Resolver.register { self.apiClient }
            .implements(APIClient.self)
    }

    private func stubDependencies() {
        stub(apiClient) { mock in
            when(mock.perform(request: any(DriverStatusRequest.self), any()))
                .thenReturn(driverStatusPublisher.eraseToAnyPublisher())
        }
    }
}

extension DriverStatusRequest: Matchable {
    public var matcher: ParameterMatcher<DriverStatusRequest> {
        ParameterMatcher<DriverStatusRequest>()
    }
}
