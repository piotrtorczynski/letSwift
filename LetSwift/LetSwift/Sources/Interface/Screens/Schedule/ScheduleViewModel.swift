//
//  ScheduleViewModel.swift
//  LetSwift
//
//  Created by Piotr Torczynski on 04/11/2022.
//

import Combine
import Resolver
import SwiftUI

enum RaceStatus: String, CaseIterable, Identifiable {
    var id: Self { self }
    
    case upcoming, finished

    var description: String {
        switch self {
        case .upcoming:
            return "Upcoming"
        case .finished:
            return "Finished"
        }
    }
}

final class ScheduleViewModel: ObservableObject {

    @Injected var api: EargastAPIServiceProtocol

    enum State {
        case loading, error(Error), loaded
    }

    private var cancellables: [AnyCancellable] = []

    // MARK: - State

    @Published var state: State = .loading
    @Published var upcomingRaces: [Race] = []
    @Published var finishedRaces: [Race] = []
    @Published var selectedSegment: RaceStatus = .upcoming

    var title: String {
        "Schedule"
    }

    func getSchedule() {
        state = .loading

        api.getCurrentSchedule()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                switch completion {
                case .finished:
                    self?.state = .loaded
                case .failure(let error):
                    self?.state = .error(error)
                }
            } receiveValue: { [weak self] races in
                guard let self else { return }
                self.finishedRaces = races.filter { self.dateFormatter.date(from: $0.date) ?? .distantPast < .now }
                self.upcomingRaces = races.filter { self.dateFormatter.date(from: $0.date) ?? .now > .now }
            }
            .store(in: &cancellables)
    }

    private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter
    }
}
