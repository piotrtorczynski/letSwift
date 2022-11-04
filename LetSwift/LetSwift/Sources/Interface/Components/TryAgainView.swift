//
//  TryAgainView.swift
//  LetSwift
//
//  Created by Piotr Torczynski on 04/11/2022.
//

import SwiftUI

public struct TryAgainErrorView: View {
    var title: String = "Sorry, we've encountered an unexpected error."
    var buttonLabel: String = "Try Reloading"
    let action: () -> Void

    public init(title: String = "Sorry, we've encountered an unexpected error.",
                buttonLabel: String = "Try Reloading",
                action: @escaping () -> Void) {
        self.title = title
        self.buttonLabel = buttonLabel
        self.action = action
    }

    public var body: some View {
        VStack(spacing: 48) {
            VStack(spacing: 8) {
                Text(title)
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.primary)
                    .multilineTextAlignment(.center)
                    .id("error_title")
            }
            PrimaryButton(label: {
                Text(buttonLabel)
                    .padding(.all, 8)
                    .frame(maxWidth: .infinity, alignment: .center)
            }, action: action)
        }
        .padding(.horizontal, 48)
        .id("try_again_view")
    }
}
