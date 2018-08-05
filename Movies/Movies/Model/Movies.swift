//
//  Movies.swift
//  Movies
//
//  Created by Matheus Garcia on 01/08/18.
//  Copyright © 2018 poppin 2018. All rights reserved.
//

import Foundation

struct Movies: Decodable {
    var movies = [Movie]()
}

extension Movies {

    enum JsonKey: String, CodingKey {

        case search = "Search"
    }

    // Infers that the json key "Search" can be used to generate Movies type
    init(from decoder: Decoder) throws {

        let container = try decoder.container(keyedBy: JsonKey.self)
        let movies = try container.decode([Movie].self, forKey: .search)
        self.movies = movies
    }
}
