//
//  APIClientTests.swift
//  LetSwiftTests
//
//  Created by Piotr Torczynski on 05/11/2022.
//

import Combine
import Cuckoo
import Foundation
import Resolver
import XCTest

@testable import Networking
@testable import LetSwift

final class APIClientTests: XCTestCase {

    private var cancellable: AnyCancellable?
    private var request = URLRequest(url: URL(string: "http://aaaa.test")!)
    private var mockUrlSession = MockURLRequestSending()
    private var mockServerEnvironmentController = MockServerEnvironmentControllerProtocol()

    override func setUp() {
        super.setUp()

        let publisher = URLSession.DataTaskPublisher(request: request, session: URLSession.shared)
        stub(mockUrlSession) { mock in
            when(mock.dataTaskPublisher(for: any())).thenReturn(publisher)
        }

        stub(mockServerEnvironmentController) { mock in
            when(mock.initialServerEnvironment.get).thenReturn(.production)
            when(mock.environment.get).thenReturn(.production)
            when(mock.environment.set(any())).thenDoNothing()
        }

        Resolver.register { self.mockServerEnvironmentController }
            .implements(ServerEnvironmentControllerProtocol.self)
    }

    // MARK: - Tests

    func testdataTaskPublisher() {
        let apiClient = DefaultAPIClient(session: mockUrlSession)

        _ = apiClient.perform(request: TestRequest())
        verify(mockUrlSession, times(1)).dataTaskPublisher(for: any())
    }
}

private struct TestRequest: APIRequest {
    typealias ReturnType = EmptyResponse

    var path: String { "fixed_path" }

    var urlBuilder: Networking.APIURLBuilder { EargastBuilder() }
}

private struct EmptyResponse: Codable {}
