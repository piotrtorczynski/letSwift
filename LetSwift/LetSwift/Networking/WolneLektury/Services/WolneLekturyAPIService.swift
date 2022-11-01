//
//  WolneLekturyAPIService.swift
//  LetSwift
//
//  Created by Piotr Torczynski on 01/11/2022.
//

import Combine
import Networking

protocol WolneLekturyAPIServiceProtocol {
    func getEbooks() -> AnyPublisher<[Book], Error>
    func getAudioBooks() -> AnyPublisher<[Book], Error>
}

final class WolneLekturyAPIService: WolneLekturyAPIServiceProtocol {

    private let apiClient: APIClient

    init(apiClient: APIClient) {
        self.apiClient = apiClient
    }

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
