//
//  MovieController.swift
//  Movies
//
//  Created by Matheus Garcia on 01/08/18.
//  Copyright © 2018 poppin 2018. All rights reserved.
//

import UIKit

// This class will handle the connection between the viewController and all the Service functions
class MovieController: NSObject {

    func searchForMoviesByName(searchFor parametherValue: String, completion: @escaping (Movies) -> Void) {

        let parameterKey = "s"

        let formater = UrlFormatter(parameterKey: parameterKey, parameterValue: parametherValue)
        let url = formater.getUrlToRequest()

        // First make the request to get data
        NetworkConnection.fetch(url: url) { (data) in

            // With the data try to parse the json into Movie objects
            Parser.parseMoviesSearch(forData: data, completion: { (movies) in
                completion(movies)
            })
        }
    }

    func getImageByUrl(urlString: String, completion: @escaping (UIImage) -> Void) {

        guard let url = URL(string: urlString) else { return }

        NetworkConnection.fetch(url: url) { (data) in
            guard let image = UIImage(data: data) else { return }
            completion(image)
        }
    }
}
