//
//  RaceRow.swift
//  LetSwift
//
//  Created by Piotr Torczynski on 04/11/2022.
//

import SwiftUI

struct RaceRow: View {
    var model: Race

    var body: some View {
        VStack {
            HStack(spacing: 16) {
                let imageClipShape = RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                makeCircuitImage(with: model.circuit)
                    .frame(width: 72, height: 72)
                    .clipShape(imageClipShape)
                    .overlay(imageClipShape.strokeBorder(.quaternary, lineWidth: 0.5))
                    .accessibility(hidden: true)

                VStack(alignment: .leading) {
                    Text(model.round)
                        .foregroundColor(Color.red)
                        .font(.headline)
                        .id("race_round")

                    Text(model.circuit.circuitName)
                        .foregroundStyle(.secondary)
                        .lineLimit(2)
                        .id("race_circuit_name")
                }

                Spacer()

                Text(model.date)
                    .foregroundColor(Color.brown)
                    .font(.headline)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 16)
        }
        .accessibilityElement(children: .combine)
    }

    private var cornerRadius: Double {
        return 36
    }

    @ViewBuilder func makeCircuitImage(with circuit: Circuit) -> some View {
        Image(circuit.location.country.lowercased())
            .id("race_circuit_image")
    }
}
