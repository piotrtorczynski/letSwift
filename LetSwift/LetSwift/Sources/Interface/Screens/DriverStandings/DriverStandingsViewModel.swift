//
//  DriverStandingsViewModel.swift
//  LetSwift
//
//  Created by Piotr Torczynski on 01/11/2022.
//

import Combine
import Resolver
import SwiftUI

final class DriverStandingsViewModel: ObservableObject {

    @Injected var api: EargastAPIServiceProtocol

    enum State {
        case loading, error(Error), loaded
    }

    private var cancellables: [AnyCancellable] = []

    // MARK: - State

    @Published var state: State = .loading
    @Published var standings: [DriverStandings] = []

    var title: String {
        "Drivers"
    }

    func getAudioBooks() {
        state = .loading

        api.getCurrentDriverStandings()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.state = .loaded
                case .failure(let error):
                    self?.state = .error(error)
                }
            } receiveValue: { [weak self] standings in
                self?.standings = standings
            }
            .store(in: &cancellables)
    }
}
