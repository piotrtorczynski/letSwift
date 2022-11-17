//
//  LetSwiftApp.swift
//  LetSwift
//
//  Created by Piotr Torczynski on 01/11/2022.
//

import Core
import Networking
import Resolver
import SwiftUI

@main
struct AppLauncher {
    static func main() throws {
        if CommandLine.isUnitTesting {
            TestApp.main()
        } else {
            LetSwiftApp.main()
        }
    }
}

struct TestApp: App {
    var body: some Scene {
        WindowGroup { Text("Running Unit Tests") }
    }
}

struct LetSwiftApp: App {
    init() {
        // UITests need to be run on the localUITest serverEnvironment and have animations off
        if CommandLine.isUITesting {
            #if DEBUG
            UIView.setAnimationsEnabled(false)
            let serverEnvironmentString = ServerEnvironment.localUITest(port: CommandLine.mockServerPort).serverPath
            guard let serverEnvironment = ServerEnvironment.getServerEnv(from: serverEnvironmentString) else { return }
            var storage = Resolver.resolve(ServerEnvironmentControllerProtocol.self)
            storage.initialServerEnvironment = serverEnvironment
            #endif
        }
    }

    var body: some Scene {
        WindowGroup {
            TabBarView(viewModel: TabViewModel())
        }
    }
}
