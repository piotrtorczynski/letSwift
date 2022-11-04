//
//  BackgroundView.swift
//  LetSwift
//
//  Created by Piotr Torczynski on 04/11/2022.
//

import SwiftUI

// Screens can wrap themselves in BackgroundView to get Navigation and the default background color
public struct BackgroundView<Content>: View where Content: View {
    public let content: Content
    public let titleDisplayMode: NavigationBarItem.TitleDisplayMode

    @inlinable public init(titleDisplayMode: NavigationBarItem.TitleDisplayMode = .large,
                           @ViewBuilder content: () -> Content) {
        self.content = content()
        self.titleDisplayMode = titleDisplayMode
    }

    public var body: some View {
        ZStack {
            Color(uiColor: .systemBackground)
                .edgesIgnoringSafeArea(.all)

            if #available(iOS 16.0, *) {
                content
                    .id("BackgroundView")
                    .scrollContentBackground(.hidden)
            } else {
                content
                    .id("BackgroundView")
            }

        }
        .navigationBarTitleDisplayMode(titleDisplayMode)
    }
}
