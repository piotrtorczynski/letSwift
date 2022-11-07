import Foundation

extension URLRequest {

    /// Convenience initializer for APIRequest
    ///
    /// - Parameter request: Request which needs to be executed
    /// - Throws: APIRequestError.incorrectURL when url could not be created
    init(request: any APIRequest) throws {
        guard let url = URLComponents(request: request).url else {
            throw APIError.incorrectURL(url: request.path)
        }
        self.init(url: url)
        
        httpMethod = request.method.rawValue

        let standartHeaders: [String: String] = [
            "Accept": "application/json",
            "Content-Type": "application/json; charset=uft-8"
        ]

        allHTTPHeaderFields = standartHeaders
            .reduce(into: request.headers) { (result, dictionary) in result[dictionary.0] = dictionary.1 }
    }
    
}
