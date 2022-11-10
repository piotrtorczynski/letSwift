//
//  DriverStatusView.swift
//  LetSwift
//
//  Created by Piotr Torczynski on 04/11/2022.
//

import SwiftUI

struct DriverStatusView: View {
    @StateObject var viewModel: DriverStatusViewModel

    var body: some View {
        BackgroundView {
            switch viewModel.state {
            case .loading:
                ProgressView()
                    .foregroundColor(Color(uiColor: .systemRed))
                    .font(.body)
                    .id("circlural_view")
            case .error(let error):
                TryAgainErrorView(title: error.localizedDescription) {
                    viewModel.getSchedule()
                }
            case .loaded:
                makeLoadedView()
            }
        }
        .accessibilityIdentifier("DriverStatusView")
        .navigationTitle(viewModel.title)
    }

    @ViewBuilder private func makeLoadedView() -> some View {
        makeAttendanceRecordContentView()
    }

    @ViewBuilder func makeAttendanceRecordContentView() -> some View {
        ScrollView {
            HStack(spacing: 16) {
                DriverAttendanceView(value: viewModel.attendance)
                    .frame(width: 96, height: 96)
                    .padding(.vertical, 24)
                    .padding(.leading, 24)

                makeAttendanceSummary()
            }
            .padding(.top, 24)
            .accessibilityIdentifier("driver_status_attendance_view")
            Spacer()
        }
    }

    @ViewBuilder func makeAttendanceSummary() -> some View {
        if let statuses = viewModel.driverStatus?.statuses {
            VStack(alignment: .leading, spacing: 8) {
                Text("Attendance")
                    .font(.headline)
                VStack(alignment: .leading) {
                    ForEach(statuses, id: \.status) { status in
                        HStack {
                            Text(status.status)
                                .font(.callout)
                            Text(status.count)
                                .font(.callout)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .font(.footnote)
            .padding(.trailing, 72)
        }
    }
}
