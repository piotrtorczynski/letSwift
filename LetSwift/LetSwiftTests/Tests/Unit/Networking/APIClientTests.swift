//
//  APIClientTests.swift
//  LetSwiftTests
//
//  Created by Piotr Torczynski on 05/11/2022.
//

import Combine
import Cuckoo
import Foundation
import XCTest

@testable import Networking
@testable import LetSwift

final class APIClientTests: XCTestCase {

    private var cancellable: AnyCancellable?
    private var request = URLRequest(url: URL(string: "http://aaaa.test")!)
    private var mockUrlSession = MockURLRequestSending()

    // MARK: - Tests

    func testdataTaskPublisher() {
        configureDownloadMocks()

        let apiClient = DefaultAPIClient(session: mockUrlSession)

        _ = apiClient.perform(request: TestRequest())
        verify(mockUrlSession, times(1)).dataTaskPublisher(for: any())
    }

    // MARK: - Helpers

    private func configureDownloadMocks() {

        let publisher = URLSession.DataTaskPublisher(request: request, session: URLSession.shared)
        stub(mockUrlSession) { mock in
            when(mock.dataTaskPublisher(for: any())).thenReturn(publisher)
        }
    }
}

private struct TestRequest: APIRequest {
    typealias ReturnType = EmptyResponse

    var path: String { "fixed_path" }

    var urlBuilder: Networking.APIURLBuilder { EargastBuilder() }
}

private struct EmptyResponse: Codable {}
