//
//  BookCell.swift
//  LetSwift
//
//  Created by Piotr Torczynski on 04/11/2022.
//

import SwiftUI

struct BookCell: View {
    var name: String
    var separatorType: TableSeparatorView.SeparatorType = .inset
    var shouldShowChevron: Bool = true
    var onTap: (() -> Void)?

    var body: some View {
        if let onTap = onTap {
            Button {
                onTap()
            } label: {
                makeContentView(shouldShowChevron: shouldShowChevron)
            }
            .id("button")
        } else {
            makeContentView()
        }
    }

    @ViewBuilder func makeContentView(shouldShowChevron: Bool = false) -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 24) {
                VStack(alignment: .leading) {
                    Text(name)
                        .font(.body)
                        .id("status_title")
//                    if let description = description, !description.isEmpty {
//                        Text(description)
//                        .foregroundColor(Colors.secondaryText)
//                        .lineLimit(2)
//                            .font(.subheadline)
//                            .id("status_subtitle")
//                    }
                }
                Spacer()
                if shouldShowChevron {
                    Image(systemName: "chevronRight")
                        .foregroundColor(Color.primary)
                }
            }
            .padding(.leading, 16)
            .padding(.trailing, 24)
            .frame(maxWidth: .infinity, alignment: .leading)

            TableSeparatorView(separatorType: separatorType, spacing: 16)
        }
    }

}
