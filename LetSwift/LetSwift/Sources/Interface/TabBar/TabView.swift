//
//  TabView.swift
//  LetSwift
//
//  Created by Piotr Torczynski on 04/11/2022.
//

import SwiftUI

struct TabBarView: View {
    @StateObject var viewModel: TabViewModel

    var body: some View {
        TabView {
            DriverStandingsView(viewModel: DriverStandingsViewModel())
                .tabItem {
                    buildTabImage(Image(systemName: "car.circle"))
                    Text("Current Season")
                }
            ScheduleView(viewModel: ScheduleViewModel())
                .tabItem {
                    buildTabImage(Image(systemName: "calendar.circle"))
                    Text("Schedule")
                }
        }
    }

    private func buildTabImage(_ image: Image) -> some View {
        Group {
            if #available(iOS 15.0, *) {
                image
                    .environment(\.symbolVariants, .none)
            } else {
                image
            }
        }
        .font(.title2)
    }
}
