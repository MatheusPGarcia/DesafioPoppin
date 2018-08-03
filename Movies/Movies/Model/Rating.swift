//
//  Rating.swift
//  Movies
//
//  Created by Matheus Garcia on 01/08/18.
//  Copyright © 2018 poppin 2018. All rights reserved.
//

import Foundation

struct Rating: Decodable {
    var source: String
    var value: String
}

// Extension to match the codingKeys from the jsonResponse with the struct elements.
extension Rating {
    enum StructKeys: String, CodingKey {

        //It's necessary to disable swiftlint identifier_name in this case because enum cases are formatted to match the api json keys
        // swiftlint:disable identifier_name
        case Source
        case Value
        // swiftlint:enable identifier_name
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StructKeys.self)

        let source: String = try container.decode(String.self, forKey: .Source)
        let value: String = try container.decode(String.self, forKey: .Value)

        self.source = source
        self.value = value
    }
}
