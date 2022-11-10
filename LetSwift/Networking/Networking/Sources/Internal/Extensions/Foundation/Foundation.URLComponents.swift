import Foundation

extension URLComponents {
    
    /// Convenience initializer for APIRequest
    ///
    /// - Parameter request: Request which needs to be executed
    init(request: any APIRequest) {
        self = {
            var components = URLComponents()
            
            components.scheme = request.urlBuilder.scheme.rawValue
            components.host = request.urlBuilder.host
            components.port = request.urlBuilder.port
            
            if let version = request.urlBuilder.version {
                components.path = "/" + NSString.path(withComponents: [
                    request.urlBuilder.root,
                    version,
                    request.path,
                ])
            } else {
                components.path = "/" + NSString.path(withComponents: [
                    request.urlBuilder.root,
                    request.path,
                ])
            }
            components.queryItems = request.serializeToQuery()
            return components
        }()
    }
    
}
