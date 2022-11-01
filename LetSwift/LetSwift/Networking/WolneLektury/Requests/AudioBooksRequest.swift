//
//  AudioBooksRequest.swift
//  LetSwift
//
//  Created by Piotr Torczynski on 01/11/2022.
//

import Networking

struct AudioBooksRequest: APIRequest {
    var urlBuilder: Networking.APIURLBuilder { WolneLekturyBuilder() }

    var path: String { "audiobooks" }
    var method: HTTPMethod { .get }
}
