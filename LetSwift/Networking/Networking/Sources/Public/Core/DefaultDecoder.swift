//
//  DefaultDecoder.swift
//  Networking
//
//  Created by Piotr Torczynski on 01/11/2022.
//

import Foundation

public final class DefaultDecoder: JSONDecoder {
    public override init() {
        super.init()
        keyDecodingStrategy = .convertFromSnakeCase
    }
}
