//
//  LetSwiftApp.swift
//  LetSwift
//
//  Created by Piotr Torczynski on 01/11/2022.
//

import Core
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

struct LetSwiftApp: App {
    var body: some Scene {
        WindowGroup {
            TabBarView(viewModel: TabViewModel())
        }
    }
}

struct TestApp: App {
    var body: some Scene {
        WindowGroup { Text("Running Unit Tests") }
    }
}
