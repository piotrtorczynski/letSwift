import Combine
import Foundation

public protocol APIClient {
    
    /// Performs specific request
    ///
    /// - Parameters:
    ///   - request: APIRequest which needs to be performed
    ///   - returns: Publisher with response or
    func perform<T: Codable>(request: APIRequest, _ decoder: JSONDecoder) ->  AnyPublisher<T, Error>
}

public extension APIClient {
    func perform<T: Codable>(request: APIRequest, _ decoder: JSONDecoder = JSONDecoder()) ->  AnyPublisher<T, Error> {
        return perform(request: request, decoder)
    }
}
