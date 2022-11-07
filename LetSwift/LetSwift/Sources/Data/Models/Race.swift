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


struct CurrentRaceSchedule: Codable {
    let data: MRDAta

    enum CodingKeys: String, CodingKey {
        case data = "MRData"
    }

    struct MRDAta: Codable {
        let raceTable: RaceTable

        enum CodingKeys: String, CodingKey {
            case raceTable = "RaceTable"
        }

        struct RaceTable: Codable {
            let races: [Race]

            enum CodingKeys: String, CodingKey {
                case races = "Races"
            }
        }
    }
}
