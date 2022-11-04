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
        BackgroundView {
            switch viewModel.state {
            case .loading:
                ProgressView()
                    .foregroundColor(Color.mint)
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
    }

    @ViewBuilder private func makeList() -> some View {
        ScrollView {
            VStack(spacing: 0) {
                ForEach(viewModel.standings, id: \.driver.code) { standing in
                    DriverRow(model: standing.driver)
                }
                .background(Color.white)
            }
        }
    }
}
