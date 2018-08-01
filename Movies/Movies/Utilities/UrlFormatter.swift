//
//  UrlFormatter.swift
//  Movies
//
//  Created by Matheus Garcia on 01/08/18.
//  Copyright © 2018 poppin 2018. All rights reserved.
//

import Foundation

// This will formate the url to the right way for request
struct UrlFormatter {

    let baseUrl: String = "http://www.omdbapi.com/?"
    let apiKey: String = "apikey=bb5305a5"
    let requestType: String = "type=movie"
    let parameterKey: String
    let parameterValue: String

    init(parameterKey: String, parameterValue: String) {
        self.parameterKey = parameterKey

        // replace all spaces to +, so the URL match with the API request pattern
        self.parameterValue = parameterValue.replacingOccurrences(of: " ", with: "+")
    }
}

extension UrlFormatter {

    public func getUrlToRequest() -> URL {

        let urlString = "\(baseUrl)\(apiKey)&\(requestType)&\(parameterKey)=\(parameterValue)"

        guard let url = URL(string: urlString) else {
            fatalError("Unable to construct url")
        }

        return url
    }
}
