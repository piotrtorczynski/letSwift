//
//  DriverStatus.swift
//  LetSwift
//
//  Created by Piotr Torczynski on 04/11/2022.
//

import Foundation

struct DriverStatus: Codable {
    let season: String
    let statuses: [Status]

    enum CodingKeys: String, CodingKey {
        case season
        case statuses = "Status"
    }
    
    struct Status: Codable {
        let count: String
        let status: String
    }
}
