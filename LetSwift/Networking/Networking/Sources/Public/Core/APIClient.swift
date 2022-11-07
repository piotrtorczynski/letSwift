import Combine
import Foundation

public protocol APIClient {
    
    /// Performs specific request
    ///
    /// - Parameters:
    ///   - request: APIRequest which needs to be performed
    ///   - returns: Publisher with response or
    func perform<T: APIRequest>(request: T, _ decoder: JSONDecoder) ->  AnyPublisher<T.ReturnType, Error>
}

public extension APIClient {
    func perform<T: APIRequest>(request: T, _ decoder: JSONDecoder = DefaultDecoder()) ->  AnyPublisher<T.ReturnType, Error> {
        return perform(request: request, decoder)
    }
}
