//
//  DriverStandings.swift
//  LetSwift
//
//  Created by Piotr Torczynski on 04/11/2022.
//

import Foundation

struct DriverStandings: Codable {
    let position: String
    let points: String
    let wins: String
    let driver: Driver

    private enum CodingKeys: String, CodingKey {
        case position
        case points
        case wins
        case driver = "Driver"
    }
}

struct Driver: Codable {
    let driverId: String
    let name: String
    let familyName: String
    let code: String
    let number: String

    private enum CodingKeys: String, CodingKey {
        case driverId
        case name = "givenName"
        case familyName
        case code
        case number = "permanentNumber"
    }
}
