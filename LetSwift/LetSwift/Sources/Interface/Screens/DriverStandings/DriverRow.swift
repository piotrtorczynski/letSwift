//
//  DriverRow.swift
//  LetSwift
//
//  Created by Piotr Torczynski on 04/11/2022.
//

import SwiftUI

struct DriverRow: View {
    var model: DriverStandings

    var body: some View {
        HStack {
            let imageClipShape = RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)

                makeAvatar(with: model.driver)
                    .frame(width: 120, height: 120)
                    .clipShape(imageClipShape)
                    .overlay(imageClipShape.strokeBorder(.quaternary, lineWidth: 0.5))
                    .accessibility(hidden: true)

            VStack(alignment: .leading) {
                Text(model.driver.name + " " + model.driver.familyName)
                    .font(.headline)

                Text(model.driver.number)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)

                Text(model.points)
                    .font(.title2)
            }

            Spacer(minLength: 0)
        }
        .font(.subheadline)
        .accessibilityElement(children: .combine)
    }

    private var cornerRadius: Double {
        return 60
    }

    @ViewBuilder func makeAvatar(with driver: Driver) -> some View {
        Image(driver.driverId)
    }
}
