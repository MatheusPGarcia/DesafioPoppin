//
//  MovieDetails.swift
//  Movies
//
//  Created by Matheus Garcia on 01/08/18.
//  Copyright © 2018 poppin 2018. All rights reserved.
//

import Foundation

struct MovieDetails: Decodable {

    let title: String?
    let released: String?
    let rated: String?
    let genre: String?
    let director: String?
    let writer: String?
    let plot: String?
    let imageUrl: String?
    let ratings: [Rating]
}

// Extension to match the codingKeys from the jsonResponse with the struct elements.
extension MovieDetails {
    enum StructKeys: String, CodingKey {
        case title = "Title"
        case released = "Released"
        case rated = "Rated"
        case genre = "Genre"
        case director = "Director"
        case writer = "Writer"
        case plot = "Plot"
        case poster = "Poster"
        case ratings = "Ratings"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StructKeys.self)

        let title: String = try container.decode(String.self, forKey: .title)
        let released: String = try container.decode(String.self, forKey: .released)
        let rated: String = try container.decode(String.self, forKey: .rated)
        let genre: String = try container.decode(String.self, forKey: .genre)
        let director: String = try container.decode(String.self, forKey: .director)
        let writer: String = try container.decode(String.self, forKey: .writer)
        let plot: String = try container.decode(String.self, forKey: .plot)
        let poster: String = try container.decode(String.self, forKey: .poster)
        let ratings: [Rating] = try container.decode([Rating].self, forKey: .ratings)

        self.title = title
        self.released = released
        self.rated = rated
        self.genre = genre
        self.director = director
        self.writer = writer
        self.plot = plot
        self.imageUrl = poster
        self.ratings = ratings
    }
}
