//
//  ViewFactory.swift
//  LetSwift
//
//  Created by Piotr Torczynski on 04/11/2022.
//

import SwiftUI

protocol ViewVending {

}

final class ViewFactory: ViewVending {
    @ViewBuilder func view(for destination: NavigationDestination) -> some View {
        switch destination {
        case .driverStatus(let driver):
            DriverStatusView(viewModel: DriverStatusViewModel(driver: driver))
        case .empty:
            EmptyView()
        }
    }
}
