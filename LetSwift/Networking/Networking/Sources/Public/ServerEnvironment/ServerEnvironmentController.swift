//
//  ServerEnvironmentController.swift
//  Networking
//
//  Created by Piotr Torczynski on 09/11/2022.
//

public protocol ServerEnvironmentControllerProtocol {
    var environment: ServerEnvironment { get set }
    var initialServerEnvironment: ServerEnvironment { get set }
}

public final class ServerEnvironmentController: ServerEnvironmentControllerProtocol {
    struct Constants {
        static let environmentStorageKey = "environmentStorageKey"
    }

    let store: UserDefaults

    public init(store: UserDefaults) {
        self.store = store
    }

    public var initialServerEnvironment: ServerEnvironment = .production

    public var environment: ServerEnvironment {
        get {
            guard let environmentString = store.string(forKey: Constants.environmentStorageKey) else {
                // TODO remove this migration after some time.
                guard let environmentString = store.string(forKey: Constants.environmentStorageKey) else {
                    return initialServerEnvironment
                }

                let serverEnvironment = ServerEnvironment.getServerEnv(from: environmentString) ?? initialServerEnvironment
                return serverEnvironment
            }

            return ServerEnvironment.getServerEnv(from: environmentString) ?? initialServerEnvironment
        }

        set(environment) {
            store.setValue(environment.serverPath, forKey: Constants.environmentStorageKey)
        }
    }

}
