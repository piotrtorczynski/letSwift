//
//  MockServer.swift
//  Testing
//
//  Created by Piotr Torczynski on 01/11/2022.
//

import Foundation
import Swifter

// MARK: - HTTPMethod

public enum HTTPMethod {
    case POST
    case GET
    case PUT
    case DELETE
}

// MARK: - HTTPStubInfo

public struct HTTPStubInfo {
    let url: String
    let jsonFilename: String
    let method: HTTPMethod
}

// MARK: - MockServer

/// Encapsulates a Swifter `HttpServer`. Allows you to stub `URLRequest`s when running tests.
public class MockServer {

    /// Swifter tiny http server
    public var server: HttpServer = {
        let server = HttpServer()
        return server
    }()

    /// The port this server is running on
    public var port: in_port_t?

    /// Place responses here for standard (REST) API calls.
    /// Use this to setup global stubs.
    public let initialStubs: [HTTPStubInfo] = []

    /// Start up the Swifter tiny http server
    public func setUp() {
        setupInitialStubs()
        startServer()
    }

    /// Stop the Swifter tiny http server
    public func tearDown() {
        server.stop()
    }

    /// Stub the specified url with the provided JSON. Useful when there's no query params needed.
    /// - Parameters:
    ///   - url: The url to stub.
    ///   - bundle: The bundle where the mock response json file lives. Defaults to `UITestCase.bundle`.
    ///   - filename: A file containing JSON to return when a URLRequest against `url` is intercepted.
    ///   - method: The HTTPMethod to stub against.
    public func addJSONStub(url: String, bundle: Bundle? = UITestCase.bundle, filename: String, method: HTTPMethod) {
        let testBundle = bundle ?? Bundle(for: type(of: self))
        let filePath = testBundle.path(forResource: filename, ofType: "json")
        let fileUrl = URL(fileURLWithPath: filePath!)
        guard let data = try? Data(contentsOf: fileUrl, options: .uncached) else {
            print("data conversion failed!!")
            return
        }

        // Looking for a file and converting it to JSON
        let json = dataToJSON(data: data)

        // Swifter makes it very easy to create stubbed responses
        let response: ((HttpRequest) -> HttpResponse) = { _ in
            return HttpResponse.ok(.json(json as AnyObject))
        }

        switch method {
        case .GET :
            server.GET[url] = response
        case .POST:
            server.POST[url] = response
        case .PUT:
            server.PUT[url] = response
        case .DELETE:
            server.DELETE[url] = response
        }
    }

    /// Stub the specified url AND query params with the provided JSON.
    /// - Parameters:
    ///   - url: The url to stub.
    ///   - jsonDict: A dict with key = concatenated sorted query params, value = file name of desired json.
    ///   - bundle: The bundle where the mock response json file lives. Defaults to `UITestCase.bundle`.
    ///   - method: The HTTPMethod to stub against.
    public func addJSONStubs(url: String, to jsonDict: [String: String], bundle: Bundle? = UITestCase.bundle, method: HTTPMethod = .GET) {

        let response: ((HttpRequest) -> HttpResponse) = { [weak self] request in
            guard let filename = self?.findFile(for: request, in: jsonDict) else {
                return HttpResponse.notFound
            }

            let testBundle = bundle ?? Bundle(for: type(of: self!))
            let filePath = testBundle.path(forResource: filename, ofType: "json")
            let fileUrl = URL(fileURLWithPath: filePath!)
            let data = try! Data(contentsOf: fileUrl, options: .uncached)
            let json = self?.dataToJSON(data: data)
            return HttpResponse.ok(.json(json as AnyObject))
        }

        switch method {
        case .GET :
            server.GET[url] = response
        case .POST:
            server.POST[url] = response
        case .PUT:
            server.PUT[url] = response
        case .DELETE:
            server.DELETE[url] = response
        }
    }

    /// Takes the request's query params, sorts them, concatenates them and uses this concatenation to search the jsonDict for the json file
    /// - Parameters:
    ///   - request: The request to be made (includes query params)
    ///   - jsonDict: A dict with key = concatenated sorted query params, value = filename of desired json.
    private func findFile(for request: HttpRequest, in jsonDict: [String: String]) -> String? {

        // concatenate the params into one string for filename (e.g., "start=2022-10-03&type=week")
        // sorted since query params can be in any given order
        let filename = request.queryParams.sorted(by: { $0.0 < $1.0 })
            .map({ $0.0 + "=" + $0.1 })
            .joined(separator: "&")

        // sort jsonDict keys in case they weren't passed in already sorted
        var jsonDictSorted = [String: String]()
        for (key, value) in jsonDict {
            var sortedKey = key.components(separatedBy: "&")
                .map { $0 + "&" }
                .sorted()
                .joined()
            sortedKey.removeLast() // remove unnecesary ending "&"
            jsonDictSorted[sortedKey] = value
        }

        // Check the dictionary for the correct file
        if let file = jsonDictSorted[filename] {
            return file
        }

        return nil
    }

    /// Adds a new stub for the given url and method with a custom request handler
    /// - Parameters:
    ///   - url: The url to stub.
    ///   - method: The HTTPMethod to stub against.
    ///   - requestHandler: The HttpResponse to return when a URLRequest against `url` is intercepted.
    public func addStub(url: String, method: HTTPMethod, requestHandler: @escaping ((HttpRequest) -> HttpResponse)) {
        switch method {
        case .GET:
            server.GET[url] = requestHandler
        case .POST:
            server.POST[url] = requestHandler
        case .PUT:
            server.PUT[url] = requestHandler
        case .DELETE:
            server.DELETE[url] = requestHandler
        }
    }

    // MARK: - Helpers

    /// Start the HTTP server on the specified port number, in case of the port number
    /// is being used it would try to find another free port.
    ///
    /// - Parameters:
    ///   - port: The port number to start the server
    ///   - maximumOfAttempts: The maximum number of attempts to find an unused port
    private func startServer(port: in_port_t = 8087, maximumOfAttempts: Int = 5) {
        // Stop the retrying when the attempts is zero
        if maximumOfAttempts == 0 {
            return
        }

        do {
            try server.start(port)
            self.port = port
            print("Server has started ( port = \(try server.port()) ). Try to connect now...")
        } catch SocketError.bindFailed(let message) where message == "Address already in use" {
            startServer(port: in_port_t.random(in: 8081..<10000), maximumOfAttempts: maximumOfAttempts - 1)
        } catch {
            print("Server start error: \(error)")
        }
    }

    /// Setup initial stubs.
    /// Use this to setup global stubs.
    private func setupInitialStubs() {
        for stub in initialStubs {
            addJSONStub(url: stub.url, filename: stub.jsonFilename, method: stub.method)
        }
    }

    /// Attempt to convert the provided `Data` to JSON.
    private func dataToJSON(data: Data) -> Any? {
        do {
            return try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        } catch let myJSONError {
            print(myJSONError)
        }
        return nil
    }
}
