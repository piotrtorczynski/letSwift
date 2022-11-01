//
//  BooksRequest.swift
//  LetSwift
//
//  Created by Piotr Torczynski on 01/11/2022.
//

import Networking

struct BooksRequest: APIRequest {
    var urlBuilder: Networking.APIURLBuilder { WolneLekturyBuilder() }

    var path: String { "books" }
    var method: HTTPMethod { .get }
}
