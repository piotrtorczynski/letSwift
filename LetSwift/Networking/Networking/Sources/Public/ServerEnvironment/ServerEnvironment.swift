//
//  ServerEnvironment.swift
//  LetSwift
//
//  Created by Piotr Torczynski on 09/11/2022.
//

import Foundation

public enum ServerEnvironment: CaseIterable {
    case production
    case localUITest(port: Int = 8087)

    public static var allCases: [ServerEnvironment] {
        return [.production, .localUITest()]
    }

    public var serverPath: String {
        switch self {
        case .production:
            return "ergast.com"
        case .localUITest:
            return "localhost"
        }
    }

    public static func getServerEnv(from environmentString: String) -> ServerEnvironment? {
        ServerEnvironment.allCases.first(where: { $0.serverPath == environmentString })
    }
}
