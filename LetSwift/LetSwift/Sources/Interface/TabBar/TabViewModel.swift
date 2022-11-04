//
//  TabViewModel.swift
//  LetSwift
//
//  Created by Piotr Torczynski on 04/11/2022.
//

import SwiftUI

enum TabState: Int, CaseIterable {
    case ebooks, audiobooks
}


final class TabViewModel: ObservableObject {
    @Published var selectedTab: TabState = .audiobooks

}
