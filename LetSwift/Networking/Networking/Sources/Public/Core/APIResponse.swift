import Foundation

/// Represents API response
public struct APIResponse {
    public let data: Data?
    public let response: HTTPURLResponse

    public init(data: Data?, response: HTTPURLResponse) {
        self.data = data
        self.response = response
    }
}
