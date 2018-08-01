//
//  Movie.swift
//  Movies
//
//  Created by Matheus Garcia on 01/08/18.
//  Copyright © 2018 poppin 2018. All rights reserved.
//

import Foundation

struct Movie: Codable {

    let title: String?
    let year: String?
    let imageUrl: String?
    let imdbId: String?
}

extension Movie {

    enum JsonKeys: String, CodingKey {

        //It's necessary to disable swiftlint identifier_name in this case because enum cases are formatted to match the api json keys
        // swiftlint:disable identifier_name
        case Title
        case Year
        case Poster
        case imdbID
        // swiftlint:enable identifier_name
    }

    // Infers custom keys to match in decode to generate Movie types
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: JsonKeys.self)

        let title = try container.decode(String.self, forKey: .Title)
        let year = try container.decode(String.self, forKey: .Year)
        let imageUrl = try container.decode(String.self, forKey: .Poster)
        let imdbId = try container.decode(String.self, forKey: .imdbID)

        self.title = title
        self.year = year
        self.imageUrl = imageUrl
        self.imdbId = imdbId
    }
}
