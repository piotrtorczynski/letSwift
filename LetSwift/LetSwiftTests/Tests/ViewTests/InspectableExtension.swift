//
//  InspectableExtension.swift
//  LetSwiftTests
//
//  Created by Piotr Torczynski on 05/11/2022.
//

import SwiftUI
import ViewInspector

@testable import LetSwift

extension ProgressView: Inspectable { }
extension ScheduleView: Inspectable { }
extension TryAgainErrorView: Inspectable { }
extension BackgroundView: Inspectable { }
