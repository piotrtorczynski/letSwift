//
//  DriverAttendanceView.swift
//  LetSwift
//
//  Created by Piotr Torczynski on 05/11/2022.
//

import SwiftUI

struct DriverAttendanceView: View {

    private enum Constants {
        static let rotationDegree = -90.0
        static let fontSize = 28.0
        static let circleSize = 96.0
    }

    let value: CGFloat

    private var progressGradient: AngularGradient {
        AngularGradient(gradient: Gradient(colors: gradientColors), center: .center, startAngle: .degrees(0), endAngle: .degrees(progress * 360))
    }

    var body: some View {
        ZStack {
            Circle()
                .stroke(Color(uiColor: .lightGray), lineWidth: 8)
            Circle()
                .trim(from: 0.015, to: value) // it starts from 0.015 to fix round lineCap UI issue.
                .stroke(progressGradient, style: StrokeStyle(lineWidth: 8, lineCap: .round))
                .rotationEffect(.degrees(Constants.rotationDegree))
                .animation(.linear, value: value)
            Text(attendanceText)
                .foregroundColor(Color(uiColor: .orange))
                .font(.system(size: Constants.fontSize))
        }
        .frame(idealWidth: Constants.circleSize, idealHeight: Constants.circleSize, alignment: .center)
    }
}

private extension DriverAttendanceView {
    var progress: CGFloat {
        min(Double(value) / 100.0, 1.0)
    }

    enum AttendanceCondition {
        case none
        case poor
        case fair
        case good
    }

    var gradientColors: [Color] {
        switch condition {
        case .good: return [Color.green]
        case .fair: return [Color.yellow, Color.orange]
        case .poor: return [Color.purple, Color.pink]
        case .none: return [Color(uiColor: .gray)]
        }
    }

    var condition: AttendanceCondition {
        switch value {
        case 85...100: return .good
        case 70...84: return .fair
        case 1...69: return .poor
        default: return .none
        }
    }

    var attendanceText: String {
        let roundedValue = floor(value)
        return roundedValue > 0 ? "\(roundedValue)%" : "--%"
    }
}
