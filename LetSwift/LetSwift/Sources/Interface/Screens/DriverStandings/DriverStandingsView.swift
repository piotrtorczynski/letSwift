//
//  DriverStandings.swift
//  LetSwift
//
//  Created by Piotr Torczynski on 01/11/2022.
//

import SwiftUI

struct DriverStandingsView: View {
    @StateObject var viewModel: DriverStandingsViewModel

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
                        viewModel.getAudioBooks()
                    }
                case .loaded:
                    makeList()
                }
            }
            .onAppear {
                viewModel.getAudioBooks()
            }
            .navigationTitle(viewModel.title)
        }
        .navigationViewStyle(.stack)
    }

    @ViewBuilder private func makeList() -> some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(viewModel.standings, id: \.driver.code) { standing in
                    DriverRow(model: standing)
                    TableSeparatorView(separatorType: .fullWidth)
                }
                .background(Color.white)
            }
        }
    }
}
