//
//  AudiobooksViewModel.swift
//  LetSwift
//
//  Created by Piotr Torczynski on 01/11/2022.
//

import SwiftUI
import Combine

final class AudiobooksViewModel: ObservableObject {

    private var cancellables: [AnyCancellable] = []

    // MARK: - State

    @Published var audiobooks: [Book] = []

    var title: String {
        "Audiobooki"
    }
}
