//
//  TableSeparatorView.swift
//  LetSwift
//
//  Created by Piotr Torczynski on 04/11/2022.
//

import SwiftUI

public struct TableSeparatorView: View {

    public enum SeparatorType {
        case inset
        case fullWidth
    }

    var separatorType: SeparatorType = .inset
    var spacing: CGFloat = 24

    public init(separatorType: SeparatorType = .inset,
                spacing: CGFloat = 24) {
        self.separatorType = separatorType
        self.spacing = spacing
    }

    public var body: some View {
        HStack(spacing: spacing) {
            if separatorType == .inset {
                Rectangle()
                    .frame(width: 1, height: 1)
                    .foregroundColor(.clear)
            }
            Rectangle()
                .frame(height: 1)
                .foregroundColor(Color.gray)
        }
    }
}
