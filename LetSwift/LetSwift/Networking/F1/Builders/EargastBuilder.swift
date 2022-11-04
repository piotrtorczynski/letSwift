//
//  EargastBuilder.swift
//  LetSwift
//
//  Created by Piotr Torczynski on 04/11/2022.
//

import Networking

final class EargastBuilder: APIURLBuilder {
    var host: String  { return "ergast.com" }
    var root: String { return "api/f1" }
}
