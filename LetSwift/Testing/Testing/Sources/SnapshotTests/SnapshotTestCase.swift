//
//  SnapshotTestCase.swift
//  Testing
//
//  Created by Piotr Torczynski on 01/11/2022.
//

import SnapshotTesting
import SwiftUI
import UIKit
import XCTest

public func assertsSnapshots<Value: View>(matching value: @autoclosure () throws -> Value, precision: Float = 0.99, file: StaticString = #file, testName: String = #function, line: UInt = #line) {
    assertSnapshot(matching: try value(),
                   as: .image(precision: precision, perceptualPrecision: defaultPerceptualPrecision, layout: .device(config: .iPhone13Pro)),
                   file: file,
                   testName: testName,
                   line: line)
}

///   perceptualPrecision: The percentage a pixel must match the source pixel to be considered a match.
///   [98-99% mimics the precision of the human eye.](http://zschuessler.github.io/DeltaE/learn/#toc-defining-delta-e)
private let defaultPerceptualPrecision: Float = {
    #if arch(x86_64)
    // When executing on Intel (CI machines) lower the `defaultPerceptualPrecision` to 98% which avoids failing tests
    // due to imperceivable differences in anti-aliasing, shadows, and blurs between Intel and Apple Silicon Macs.
    return 0.98
    #else
    // The snapshots were generated on Apple Silicon Macs, so they match 100%.
    return 1.0
    #endif
}()

/// Protocol for Provider and Experience Module snapshot tests.
public protocol SnapshotTestCase {
    /// Performs setup logic prior to running a snapshot test.
    func setUpSnapshotTests()

    /// Performs tear down logic after running a snapshot test.
    func tearDownSnapshotTests()
}

extension SnapshotTestCase {
    func setUpSnapshotTests() {
        if !UIDevice.current.name.contains("iPhone 14 Pro") {
            fatalError("Switch to using iPhone 14 Pro for these tests.")
        }

        UIView.setAnimationsEnabled(false)
        UIApplication.shared.keyWindow?.layer.speed = 100

        isRecording = false
    }

    func tearDownSnapshotTests() {
        UIView.setAnimationsEnabled(true)
        UIApplication.shared.keyWindow?.layer.speed = 1.0
    }
}

private extension UIApplication {
    var keyWindow: UIWindow? {
        return UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first(where: { $0 is UIWindowScene })
            .flatMap({ $0 as? UIWindowScene })?.windows
            .first(where: \.isKeyWindow)
    }
}
