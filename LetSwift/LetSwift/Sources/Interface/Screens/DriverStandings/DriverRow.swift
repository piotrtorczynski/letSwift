//
//  DriverRow.swift
//  LetSwift
//
//  Created by Piotr Torczynski on 04/11/2022.
//

import SwiftUI

struct DriverRow: View {
    var model: DriverStandings

    var onTap: (() -> Void)?

    var body: some View {
        if let onTap = onTap {
            Button {
                onTap()
            } label: {
                makeContentView()
            }
            .id("button")
        } else {
            makeContentView()
        }
    }

    @ViewBuilder func makeContentView() -> some View {
        VStack(spacing: 0) {
            HStack(spacing: 16) {
                VStack(spacing: 16) {
                    makeAvatar(with: model.driver)
                        .frame(width: 120, height: 120)
                        .clipped()
                        .accessibility(hidden: true)

                    Text(model.driver.number)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                        .id("driver_number")
                }

                VStack(alignment: .leading) {
                    Text(model.driver.name + " " + model.driver.familyName)
                        .font(.headline)
                        .id("driver_name")

                    Text("Score: " + model.points)
                        .font(.title2)
                        .id("driver_score")
                }

                Spacer()
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 16)

        }
        .accessibilityIdentifier("driver_row")
    }

    @ViewBuilder func makeAvatar(with driver: Driver) -> some View {
        Image(driver.driverId)
            .id("driver_image")
    }
}
