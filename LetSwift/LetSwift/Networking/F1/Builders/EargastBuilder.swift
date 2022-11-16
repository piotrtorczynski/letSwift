//
//  EargastBuilder.swift
//  LetSwift
//
//  Created by Piotr Torczynski on 04/11/2022.
//

import Networking
import Resolver

final class EargastBuilder: APIURLBuilder {

    @Injected private var serverEnvironmentProvider: ServerEnvironmentControllerProtocol

    var host: String  { return serverEnvironmentProvider.environment.serverPath }
    var root: String { return "api/f1" }

    var scheme: Scheme {
        switch serverEnvironmentProvider.initialServerEnvironment {
        case .production:
            return .https
        default:
            return .http
        }
    }

    var port: Int? {
        switch serverEnvironmentProvider.initialServerEnvironment {
        case .localUITest(let port):
            return port
        default:
            return nil
        }
    }
}
