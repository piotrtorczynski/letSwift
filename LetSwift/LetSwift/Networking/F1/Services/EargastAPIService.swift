//
//  EargastAPIService.swift
//  LetSwift
//
//  Created by Piotr Torczynski on 04/11/2022.
//

import Combine
import Networking
import Resolver

protocol EargastAPIServiceProtocol {
    func getCurrentDriverStandings() -> AnyPublisher<[DriverStandings], Error>
}

final class EargastAPIService: EargastAPIServiceProtocol {
    @Injected private var apiClient: APIClient

    func getCurrentDriverStandings() -> AnyPublisher<[DriverStandings], Error> {
        let request: AnyPublisher<CurrentDriverStandings, Error> = apiClient.perform(request: CurrentSeasonRequest())
        return request
            .map { $0.data.standings.standingsLists.first?.driverStandings ?? [] }
            .eraseToAnyPublisher()
    }
}

private struct CurrentDriverStandings: Codable {
    let data: MRDAta

    enum CodingKeys: String, CodingKey {
        case data = "MRData"
    }

    struct MRDAta: Codable {
        let standings: StandingsTable

        enum CodingKeys: String, CodingKey {
            case standings = "StandingsTable"
        }

        struct StandingsTable: Codable {
            let standingsLists: [StandingsLists]

            enum CodingKeys: String, CodingKey {
                case standingsLists = "StandingsLists"
            }

            struct StandingsLists: Codable {
                let driverStandings: [DriverStandings]

                enum CodingKeys: String, CodingKey {
                    case driverStandings = "DriverStandings"
                }
            }
        }
    }
}
