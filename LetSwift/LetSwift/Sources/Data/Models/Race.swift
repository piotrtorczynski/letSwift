//
//  Race.swift
//  LetSwift
//
//  Created by Piotr Torczynski on 04/11/2022.
//

import Foundation

struct Race: Codable {
    let season: String
    let round: String
    let raceName: String
    let circuit: Circuit
    let date: String

    enum CodingKeys: String, CodingKey {
        case season
        case round
        case raceName
        case circuit = "Circuit"
        case date
    }
}

struct Circuit: Codable {
    let circuitId: String
    let circuitName: String
    let location: Location

    enum CodingKeys: String, CodingKey {
        case circuitId
        case circuitName
        case location = "Location"
    }

    struct Location: Codable {
        let country: String
    }
}
