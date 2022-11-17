//
//  NavigationDestination.swift
//  LetSwift
//
//  Created by Piotr Torczynski on 04/11/2022.
//

import Foundation

enum NavigationDestination: Equatable, Identifiable {
    var id: String { return String(reflecting: self) }

    static func == (lhs: NavigationDestination, rhs: NavigationDestination) -> Bool {
        lhs.id == rhs.id
    }

    case empty
    case driverStatus(Driver)
}
