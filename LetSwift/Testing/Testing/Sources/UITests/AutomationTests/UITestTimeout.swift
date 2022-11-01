//
//  UITestTimeout.swift
//  Testing
//
//  Created by Piotr Torczynski on 01/11/2022.
//

import Foundation

/// Common UI test TimeIntervals
public enum UITestTimeout: TimeInterval {
    case short = 1
    case standard = 5
    case long = 10
}
