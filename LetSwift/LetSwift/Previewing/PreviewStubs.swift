//
//  PreviewStubs.swift
//  LetSwift
//
//  Created by Piotr Torczynski on 06/11/2022.
//

import Foundation
import Networking

#if TEST
@testable import LetSwift
#endif

#if DEBUG
struct PreviewStubs {
    struct Data {
        private static var decoder: JSONDecoder {
            DefaultDecoder()
        }

        static var races: [Race] {
            return try! decoder.decode([Race].self, from: LocalJsonParsing.getJsonData(from: "races"))
        }
    }
}

struct LocalJsonParsing {
    static func getJsonData(from filename: String) -> Data {
        let path = Bundle.main.path(forResource: filename, ofType: "json")!
        return try! Data(contentsOf: URL(fileURLWithPath: path))
    }
}

#endif
