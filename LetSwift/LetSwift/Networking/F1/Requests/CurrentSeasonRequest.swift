//
//  CurrentSeasonRequest.swift
//  LetSwift
//
//  Created by Piotr Torczynski on 04/11/2022.
//

import Networking

struct CurrentSeasonRequest: APIRequest {
    var urlBuilder: Networking.APIURLBuilder { EargastBuilder() }

    var path: String { "current/driverStandings.json" }
    var method: HTTPMethod { .get }
}
