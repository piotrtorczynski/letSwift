//
//  WolneLekturyAPIService.swift
//  LetSwift
//
//  Created by Piotr Torczynski on 01/11/2022.
//

import Combine
import Networking
import Resolver

protocol WolneLekturyAPIServiceProtocol {
    func getEbooks() -> AnyPublisher<[Book], Error>
    func getAudioBooks() -> AnyPublisher<[Book], Error>
}

final class WolneLekturyAPIService: WolneLekturyAPIServiceProtocol {

    @Injected private var apiClient: APIClient

    func getEbooks() -> AnyPublisher<[Book], Error> {
        apiClient.perform(request: BooksRequest())
    }

    func getAudioBooks() -> AnyPublisher<[Book], Error> {
        apiClient.perform(request: AudioBooksRequest())
    }
}

struct Book: Codable {
    let title: String
    let href: String
    let simpleThumb: String
    let author: String
    let coverColor: String
    let genre: String
}
