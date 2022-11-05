//
//  URLRequestSending.swift
//  Networking
//
//  Created by Piotr Torczynski on 05/11/2022.
//

import Combine

public protocol URLRequestSending {
    var configuration: URLSessionConfiguration { get }
    func dataTaskPublisher(for request: URLRequest) -> URLSession.DataTaskPublisher
}

extension URLSession: URLRequestSending {}
