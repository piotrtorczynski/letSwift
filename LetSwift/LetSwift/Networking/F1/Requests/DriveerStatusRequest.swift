//
//  DriveerStatusRequest.swift
//  LetSwift
//
//  Created by Piotr Torczynski on 04/11/2022.
//

import Networking

struct DriverStatusRequest: APIRequest {
    typealias ReturnType = DriverStatusResponse
    
    var urlBuilder: Networking.APIURLBuilder { EargastBuilder() }

    var path: String { "2022/drivers/\(driverId)/status.json" }
    var method: HTTPMethod { .get }

    private let driverId: String

    init(driverId: String) {
        self.driverId = driverId
    }
}
