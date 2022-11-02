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
        // don't register real dependencies while unit testing
        guard !CommandLine.isUnitTesting else { return }
        registerNetworking()
        registerAPIs()
    }

    private static func registerNetworking() {
        register { DefaultAPIClient() as APIClient }
    }

    private static func registerAPIs() {
        register { WolneLekturyAPIService() }
            .implements(WolneLekturyAPIServiceProtocol.self)
    }
}
