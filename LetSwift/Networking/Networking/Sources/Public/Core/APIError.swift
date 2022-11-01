/// Error which may occur during creating request
///
/// - incorrectURL: Indicates incorrect URL - might be because of incorrect URL, host or path
/// - unexpectedStatusCode: Response status code was out of accepted range
/// - noResponse: Response was missing or not HTTP response
/// - internetConnectionUnavailable: Internet connection went out
public enum APIError: Error, Equatable {
    case incorrectURL(url: String)
    case unexpectedStatusCode(statusCode: Int)
    case noResponse
    case internetConnectionUnavailable
}
