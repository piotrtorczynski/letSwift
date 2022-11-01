//
//  CommandLineExtensions.swift
//  Core
//
//  Created by Piotr Torczynski on 01/11/2022.
//

import Foundation

extension CommandLine {

    private static let defaultMockServerPort = 8087

    /// Determines if a unit test is currently running or not.
    public static var isUnitTesting: Bool {
        return arguments.contains("isUnitTesting")
    }

    /// Determines if a UI test is currently running or not.
    public static var isUITesting: Bool {
        return arguments.contains("isUITesting")
    }

    public static var mockServerPort: Int {
        guard let first = arguments.first(where: { $0.hasPrefix("--port") }) else {
            return defaultMockServerPort
        }
        let components = first.components(separatedBy: ":")
        guard components.count == 2 else { return defaultMockServerPort }
        guard let port = Int(components[1]) else { return defaultMockServerPort }

        return port
    }
}
