//
//  DriverRow.swift
//  LetSwift
//
//  Created by Piotr Torczynski on 04/11/2022.
//

import SwiftUI

struct DriverRow: View {
    var model: Driver

    var body: some View {
        HStack(alignment: .top) {
            let imageClipShape = RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
            makeAvatar(with: model)
                .frame(width: 60, height: 60)
                .clipShape(imageClipShape)
                .overlay(imageClipShape.strokeBorder(.quaternary, lineWidth: 0.5))
                .accessibility(hidden: true)

            VStack(alignment: .leading) {
                Text(model.name)
                    .font(.headline)

                Text(model.familyName)
                    .lineLimit(2)

                Text(model.number)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }

            Spacer(minLength: 0)
        }
        .font(.subheadline)
        .accessibilityElement(children: .combine)
    }

    var cornerRadius: Double {
        #if os(iOS)
        return 10
        #else
        return 4
        #endif
    }

    @ViewBuilder func makeAvatar(with driver: Driver) -> some View {
        if let initials = makeInitials(for: driver) {
            ZStack {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 56, height: 56)
                Text(initials)
                    .font(.title2)
                    .foregroundColor(Color.white)
            }
        }
    }

    private func makeInitials(for driver: Driver) -> String? {
        guard let first = driver.name.first,
              let last = driver.familyName.first else { return nil }
        return (String(first) + String(last)).uppercased()
    }

}
