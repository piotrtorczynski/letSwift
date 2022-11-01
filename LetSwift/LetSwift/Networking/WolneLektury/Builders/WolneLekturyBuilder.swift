//
//  WolneLekturyBuilder.swift
//  LetSwift
//
//  Created by Piotr Torczynski on 01/11/2022.
//

import Networking

final class WolneLekturyBuilder: APIURLBuilder {
    var host: String  { return "wolnelektury.pl" }
    var root: String { return "api" }
}
