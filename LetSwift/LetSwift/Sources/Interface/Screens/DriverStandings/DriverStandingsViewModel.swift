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
    @Injected var viewFactory: ViewFactory

    enum State {
        case loading, error(Error), loaded
    }

    private var cancellables: [AnyCancellable] = []

    // MARK: - State

    @Published var state: State = .loading
    @Published var standings: [DriverStandings] = []
    @Published var isShowingDetails: Bool = false

    @Published var destination: NavigationDestination = .empty {
        didSet {
            isShowingDetails = destination != .empty
        }
    }

    init() {
        getStandings()
    }

    var title: String {
        "Drivers Standings"
    }

    func getStandings() {
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
