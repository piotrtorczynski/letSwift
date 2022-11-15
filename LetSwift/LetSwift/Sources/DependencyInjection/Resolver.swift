//
//  Resolver.swift
//  LetSwift
//
//  Created by Piotr Torczynski on 01/11/2022.
//

import Core
import Networking
import Resolver

extension Resolver: ResolverRegistering {
    public static func registerAllServices() {
        // Don't register real dependencies while unit testing
        guard !CommandLine.isUnitTesting else { return }

        registerNetworking()
        registerCache()
        registerAPIs()
        registerNaviation()
    }

    private static func registerCache() {

        register(UserDefaults.self) {
            return UserDefaults.standard
        }
        .scope(.application)

        register { ServerEnvironmentController(store: resolve()) }
            .implements(ServerEnvironmentControllerProtocol.self)
            .scope(.application)
    }

    private static func registerNetworking() {
        register { DefaultAPIClient(session: resolve()) }
            .implements(APIClient.self)

        register { URLSession.shared }
            .implements(URLRequestSending.self)
    }

    private static func registerAPIs() {
        register { EargastAPIService() }
            .implements(EargastAPIServiceProtocol.self)
    }

    private static func registerNaviation() {
        register { ViewFactory() }
            .implements(ViewVending.self)
    }
}
