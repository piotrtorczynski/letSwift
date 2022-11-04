//
//  AnalyticsEvent.swift
//  Analytics
//
//  Created by Piotr Torczynski on 04/11/2022.
//

import Foundation

public typealias AnalyticsEventParameter = [String: AnalyticsEventValue]

public protocol AnalyticsTrackerProtocol {
    func trackEvent(event: AnalyticsEvent)
}

public protocol AnalyticsEvent {
    var name: String { get }
    var metadata: AnalyticsEventParameter? { get }
}

public enum AnalyticsEventValue {
    case `true`
    case `false`
    case string(value: String)
    case int(value: Int)
    case float(value: Float)

    var analyticsValue: String {
        switch self {
            case .false: return "0"
            case .true: return "1"
            case let .string(value: stringValue): return stringValue
            case let .int(value: intValue): return "\(intValue)"
            case let .float(value: floatValue): return "\(floatValue)"
        }
    }
}

public extension AnalyticsEvent {
    var metadata: AnalyticsEventParameter? { return nil }
}

public struct DefaultAnalyticsEvent: AnalyticsEvent {
    public let name: String

    public init(name: String) {
        self.name = name
    }
}
