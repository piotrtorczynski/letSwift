//
//  DriveerStatusRequest.swift
//  LetSwift
//
//  Created by Piotr Torczynski on 04/11/2022.
//


import Networking

struct DriveerStatusRequest: APIRequest {
    var urlBuilder: Networking.APIURLBuilder { EargastBuilder() }

    var path: String { "2022/drivers/\(driverId)/status.json" }
    var method: HTTPMethod { .get }

    let driverId: String
}
