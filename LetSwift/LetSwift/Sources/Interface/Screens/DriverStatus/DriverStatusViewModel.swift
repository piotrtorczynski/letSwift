//
//  DriverStatusViewModel.swift
//  LetSwift
//
//  Created by Piotr Torczynski on 04/11/2022.
//

import Combine
import Resolver
import SwiftUI

final class DriverStatusViewModel: ObservableObject {

    @Injected var api: EargastAPIServiceProtocol

    enum State {
        case loading, error(Error), loaded
    }

    private var cancellables: [AnyCancellable] = []
    private let driver: Driver

    // MARK: - State

    @Published var state: State = .loading
    @Published var driverStatus: DriverStatus?

    init(driver: Driver) {
        self.driver = driver
        getSchedule()
    }

    var title: String {
        driver.name + " " + driver.familyName
    }

    var attendance: CGFloat {
        guard let driverStatus = driverStatus, let finished = driverStatus.statuses.first(where: { $0.status.lowercased() == "finished" }), let count = Int(finished.count) else { return 0 }
        return CGFloat(count) / CGFloat(allRacesCount) * 100
    }

    func getSchedule() {
        state = .loading

        api.getDriverStatus(driverId: driver.driverId)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.state = .loaded
                case .failure(let error):
                    self?.state = .error(error)
                }
            } receiveValue: { [weak self] status in
                self?.driverStatus = status
            }
            .store(in: &cancellables)
    }

    private var allRacesCount: Int {
        guard let driverStatus = driverStatus else { return 0 }
        let count = driverStatus.statuses
            .compactMap({ Int($0.count) })
            .reduce(0, +)
        return count
    }
}
