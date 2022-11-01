import Foundation

/// Defines request's method
public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case options = "OPTIONS"
}

public protocol APIRequest {
    
    /// HTTP method
    var method: HTTPMethod { get }
    
    /// Path to resource
    var path: String { get }
    
    /// HTTP method
    var urlBuilder: APIURLBuilder { get }

    var headers: [String: String] { get }

    /// Queries
    var query: [String: APIQueryParameter] { get }

    var requiresAuthorization: Bool { get }

}

// MARK: - Default values for API request
public extension APIRequest {
    
    var method: HTTPMethod { return .get }
    
    var query: [String: APIQueryParameter] { return [:] }
    
    var headers: [String: String] { return [:] }

    var requiresAuthorization: Bool { return true }
}

extension APIRequest {
    func serializeToQuery() -> [URLQueryItem] {
        return self.query.flatMap { serializeToQueryComponent(key: $0, value: $1) }
    }

    private func serializeToQueryComponent(key: String, value: APIQueryParameter) -> [URLQueryItem] {
        switch value {
        case .bool(let bool):
            return [URLQueryItem(name: key, value: bool ? "1" : "0")]
        case .double(let double):
            return [URLQueryItem(name: key, value: "\(double)")]
        case .int(let int):
            return [URLQueryItem(name: key, value: "\(int)")]
        case .string(let string):
            return [URLQueryItem(name: key, value: string)]
        }
    }
}
