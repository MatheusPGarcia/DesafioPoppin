//
//  MovieDetails.swift
//  Movies
//
//  Created by Matheus Garcia on 01/08/18.
//  Copyright © 2018 poppin 2018. All rights reserved.
//

import Foundation

struct MovieDetails: Decodable {

    let title: String
    let released: String
    let rated: String
    let genre: String
    let director: String
    let writer: String
    let plot: String
    let imageUrl: String
    let ratings: [Rating]
}

// Extension to match the codingKeys from the jsonResponse with the struct elements.
extension MovieDetails {
    enum StructKeys: String, CodingKey {
        case Title
        case Released
        case Rated
        case Genre
        case Director
        case Writer
        case Plot
        case Poster
        case Ratings
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StructKeys.self)

        let title: String = try container.decode(String.self, forKey: .Title)
        let released: String = try container.decode(String.self, forKey: .Released)
        let rated: String = try container.decode(String.self, forKey: .Rated)
        let genre: String = try container.decode(String.self, forKey: .Genre)
        let director: String = try container.decode(String.self, forKey: .Director)
        let writer: String = try container.decode(String.self, forKey: .Writer)
        let plot: String = try container.decode(String.self, forKey: .Plot)
        let poster: String = try container.decode(String.self, forKey: .Poster)
        let ratings: [Rating] = try container.decode([Rating].self, forKey: .Ratings)

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
