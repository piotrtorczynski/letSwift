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
    func getCurrentSchedule() -> AnyPublisher<[Race], Error>
    func getDriverStatus(driverId: String) -> AnyPublisher<DriverStatus, Error>
}

final class EargastAPIService: EargastAPIServiceProtocol {
    @Injected private var apiClient: APIClient

    func getCurrentDriverStandings() -> AnyPublisher<[DriverStandings], Error> {
        apiClient.perform(request: CurrentSeasonRequest())
            .map { $0.data.standings.standingsLists.first?.driverStandings ?? [] }
            .eraseToAnyPublisher()
    }

    func getCurrentSchedule() -> AnyPublisher<[Race], Error> {
        apiClient.perform(request: CurrentRaceScheduleRequest())
            .map { $0.data.raceTable.races }
            .eraseToAnyPublisher()
    }

    func getDriverStatus(driverId: String) -> AnyPublisher<DriverStatus, Error> {
        apiClient.perform(request: DriverStatusRequest(driverId: driverId))
            .map { $0.data.statusTable }
            .eraseToAnyPublisher()
    }
}
