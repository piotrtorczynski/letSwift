//
//  ScheduleView.swift
//  LetSwift
//
//  Created by Piotr Torczynski on 04/11/2022.
//

import SwiftUI

struct ScheduleView: View {
    @StateObject var viewModel: ScheduleViewModel

    var body: some View {
        NavigationView {
            BackgroundView {
                switch viewModel.state {
                case .loading:
                    ProgressView()
                        .foregroundColor(Color(uiColor: .systemRed))
                        .font(.body)
                        .id("circlural_view")
                case .error(let error):
                    TryAgainErrorView(title: error.localizedDescription) {
                        viewModel.getSchedule()
                    }
                case .loaded:
                    makeLoadedView()
                        .id("races_view")
                }
            }
            .onAppear {
                viewModel.getSchedule()
            }
            .navigationTitle(viewModel.title)
        }
        .navigationViewStyle(.stack)
    }

    @ViewBuilder private func makeLoadedView() -> some View {
        VStack {
            Picker("", selection: $viewModel.selectedSegment) {
                ForEach(RaceStatus.allCases) { value in
                    Text(value.description)
                }
            }
            .pickerStyle(.segmented)

            ScrollView {
                VStack(spacing: 0) {
                    switch viewModel.selectedSegment {
                    case .upcoming:
                        makeUpcomingRacesView()
                    case .finished:
                        makeFinishedRacesView()
                    }
                }
            }
        }
    }

    @ViewBuilder private func makeUpcomingRacesView() -> some View {
        ForEach(viewModel.upcomingRaces, id: \.date) { race in
            RaceRow(model: race)
            TableSeparatorView(separatorType: .fullWidth)
        }
        .id("upcoming_races_view")
    }

    @ViewBuilder private func makeFinishedRacesView() -> some View {
        ForEach(viewModel.finishedRaces, id: \.date) { race in
            RaceRow(model: race)
            TableSeparatorView(separatorType: .fullWidth)
        }
        .id("finished_races_view")
    }
}
