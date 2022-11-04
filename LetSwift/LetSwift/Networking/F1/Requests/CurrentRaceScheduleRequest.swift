//
//  CurrentRaceSchedule.swift
//  LetSwift
//
//  Created by Piotr Torczynski on 04/11/2022.
//

import Networking

struct CurrentRaceScheduleRequest: APIRequest {
    var urlBuilder: Networking.APIURLBuilder { EargastBuilder() }

    var path: String { "current.json" }
    var method: HTTPMethod { .get }
}
