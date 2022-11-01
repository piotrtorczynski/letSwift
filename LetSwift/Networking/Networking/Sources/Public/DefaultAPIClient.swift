import Foundation
import Combine

public final class DefaultAPIClient: APIClient {
    // MARK: Properties
    
    private var session: URLSession
    
    // MARK: Initializers

    public init(session: URLSession = .shared) {
        self.session = session
    }

    // MARK: APIClient

    public func perform<T: Decodable>(request: APIRequest, _ decoder: JSONDecoder = DefaultDecoder()) -> AnyPublisher<T, Error> {
        return send(request: request, decoder)
    }
    
    // MARK: Private

    private func send<T: Decodable>(request: APIRequest, _ decoder: JSONDecoder) -> AnyPublisher<T, Error>{
        var urlRequest: URLRequest
        if request.requiresAuthorization {
            let configuartion = URLSessionConfiguration.default
            configuartion.httpAdditionalHeaders = request.headers
            session = URLSession(configuration: configuartion)
        }
        
        do {
            urlRequest = try URLRequest(request: request)
            urlRequest.cachePolicy = .reloadRevalidatingCacheData
        } catch let error {
            return Fail(error: error).eraseToAnyPublisher()
        }

        return session.dataTaskPublisher(for: urlRequest)
            .mapError { error -> Error in
                if (error as NSError).code == NSURLErrorNotConnectedToInternet {
                    return APIError.internetConnectionUnavailable
                } else {
                    return error
                }
            }
            .handleEvents(receiveOutput: { output in
                #if DEBUG
                print("-----------------------START-----------------------")
                print("URL: \(urlRequest.url!)")
                print("Method: \(urlRequest.httpMethod!)")
                print("Status Code: \((output.response as? HTTPURLResponse)?.statusCode ?? 0)")
                print("Request Headers: \(urlRequest.allHTTPHeaderFields ?? [:])")
                print("Response Headers: \((output.response as? HTTPURLResponse)?.allHeaderFields as? [String: Any] ?? [:])")
                #endif
            })
            .map { $0.data }
            .handleEvents(receiveOutput: {
                #if DEBUG
                print("Response:")
                print(NSString(data: $0, encoding: String.Encoding.utf8.rawValue) ?? "")
                print("-----------------------END-----------------------")
                #endif
            })
            .decode(type: T.self, decoder: decoder)
            .mapError { _ in APIError.noResponse }
            .eraseToAnyPublisher()
    }
}
