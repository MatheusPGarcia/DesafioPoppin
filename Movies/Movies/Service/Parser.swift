//
//  Parser.swift
//  Movies
//
//  Created by Matheus Garcia on 01/08/18.
//  Copyright © 2018 poppin 2018. All rights reserved.
//

import Foundation

class Parser: NSObject {

    class func parseMoviesSearch(forData data: Data, completion: @escaping (Movies?) -> Void) {

        do {
            let decoder = JSONDecoder()
            var moviesResponse = try decoder.decode(Movies.self, from: data)
            moviesResponse.movies = handleNilForMovies(moviesResponse)
            completion(moviesResponse)
        } catch {
            print("Error decoding Json: \(error)")
            completion(nil)
        }
    }

    class func parseMovieDetails(forData data: Data, completion: @escaping (MovieDetails) -> Void) {

        do {
            let decoder = JSONDecoder()
            var detailsResponse = try decoder.decode(MovieDetails.self, from: data)
            detailsResponse = treatDetails(detailsResponse)
            completion(detailsResponse)
        } catch {
            // TODO: Handle error in decoding Json
            print("Error decoding Json: \(error)")
        }
    }

    // When the API doesn't have an information they will return the value "N/A" for the key
    // in this func the movie type will be treated to have value nil instead of "N/A"
    private class func handleNilForMovies(_ movies: Movies) -> [Movie] {

        var moviesTreated = [Movie]()

        for movie in movies.movies {
            let treatedMovie = treatMovie(movie)
            moviesTreated.append(treatedMovie)
        }

        return moviesTreated
    }

    // This func receives a movie with "N/A" fields and return the movie with "N/A" replaced for nil
    private class func treatMovie(_ movie: Movie) -> Movie {
        let title = treatField(movie.title!)
        let year = treatField(movie.year!)
        let imdbId = treatField(movie.imdbId!)
        let imageUrl = treatField(movie.imageUrl!)

        let newMovie = Movie(title: title, year: year, imageUrl: imageUrl, imdbId: imdbId)
        return newMovie
    }

    // This func receives MovieDetails with "N/A" fields and return the object with "N/A" replaced for nil
    private class func treatDetails(_ movie: MovieDetails) -> MovieDetails {
        let title = treatField(movie.title!)
        let released = treatField(movie.released!)
        let rated = treatField(movie.rated!)
        let genre = treatField(movie.genre!)
        let director = treatField(movie.director!)
        let writer = treatField(movie.writer!)
        let plot = treatField(movie.plot!)
        let imageUrl = treatField(movie.imageUrl!)

        let newMovie = MovieDetails(title: title,
                                    released: released,
                                    rated: rated,
                                    genre: genre,
                                    director: director,
                                    writer: writer,
                                    plot: plot,
                                    imageUrl: imageUrl,
                                    ratings: movie.ratings)

        return newMovie
    }

    // This func verify if the field is "N/A", if it's return nil, else it will return the var self value
    private class func treatField(_ variable: String) -> String? {
        if variable == "N/A" {
            return nil
        } else {
            return variable
        }
    }
}
