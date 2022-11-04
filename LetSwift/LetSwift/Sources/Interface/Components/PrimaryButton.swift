//
//  PrimaryButton.swift
//  LetSwift
//
//  Created by Piotr Torczynski on 04/11/2022.
//

import SwiftUI

public struct PrimaryButton<Label>: View where Label: View {
    private let buttonWidth: CGFloat = 240

    var isDisabled: Bool = false
    let label: () -> Label
    var action: (() -> Void)?

    public init(isDisabled: Bool = false,
                label: @escaping () -> Label,
                action: (() -> Void)? = nil) {
        self.isDisabled = isDisabled
        self.label = label
        self.action = action
    }

    public var body: some View {
            Button(action: {
                action?()
            }, label: label)
            .buttonStyle(PrimaryButtonStyle())
            .id("button")
            .disabled(isDisabled)
            .frame(width: buttonWidth, height: 50)
    }
}

struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color(red: 0, green: 0, blue: 0.2))
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}
