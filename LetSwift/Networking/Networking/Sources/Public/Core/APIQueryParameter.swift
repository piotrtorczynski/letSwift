import Foundation

/// Enum used to parse swift types into URLQueryItem
///
/// - string: string value
/// - bool: bool value
/// - int: int value
/// - double: double value
public enum APIQueryParameter {
    case string(String)
    case bool(Bool)
    case int(Int)
    case double(Double)
}

extension APIQueryParameter: Equatable {
    public static func ==(lhs: APIQueryParameter, rhs: APIQueryParameter) -> Bool {
        switch (lhs, rhs) {
            case (.int(let lhs), .int(let rhs)):
                return lhs == rhs
            case (.double(let lhs), .double(let rhs)):
                return lhs == rhs
            case (.bool(let lhs), .bool(let rhs)):
                return lhs == rhs
            case (.string(let lhs), .string(let rhs)):
                return lhs == rhs
            default:
                return false
        }
    }
}
