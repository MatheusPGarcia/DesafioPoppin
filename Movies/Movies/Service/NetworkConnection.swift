//
//  NetworkConnection.swift
//  Movies
//
//  Created by Matheus Garcia on 01/08/18.
//  Copyright © 2018 poppin 2018. All rights reserved.
//

import Foundation

class NetworkConnection {

    // This func will be used to fetch all data
    class func fetch(url: URL, completion: @escaping (Data) -> Void) {

        let request = URLRequest(url: url)

        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration)

        session.dataTask(with: request) { (data, _, error) in
            if let error = error {
                // TODO: Handle error in dataTask
                print("Error fetching json: \(error)")
                return
            }

            if let data = data {
                completion(data)
            }
        }.resume()
    }
}
