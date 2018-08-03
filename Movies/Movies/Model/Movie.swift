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

        case title = "Title"
        case year = "Year"
        case poster = "Poster"
        case imdbID
    }

    // Infers custom keys to match in decode to generate Movie types
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: JsonKeys.self)

        let title = try container.decode(String.self, forKey: .title)
        let year = try container.decode(String.self, forKey: .year)
        let imageUrl = try container.decode(String.self, forKey: .poster)
        let imdbId = try container.decode(String.self, forKey: .imdbID)

        self.title = title
        self.year = year
        self.imageUrl = imageUrl
        self.imdbId = imdbId
    }
}
