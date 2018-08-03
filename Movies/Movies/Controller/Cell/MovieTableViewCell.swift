//
//  MovieTableViewCell.swift
//  Movies
//
//  Created by Matheus Garcia on 01/08/18.
//  Copyright © 2018 poppin 2018. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    
    var movie: Movie?

    override func layoutSubviews() {

        guard let movie = movie else { return }

        if let name = movie.title {
            titleLabel.text = name
        } else {
            titleLabel.text = "Title not provided by the api"
        }

        if let year = movie.year {
            yearLabel.text = year
        } else {
            yearLabel.text = "Year not provided by the api"
        }

        if let imageUrl = movie.imageUrl {
            setImagePoster(imageUrl)
        } else {
            self.posterImage.image = UIImage(named: "NoImageAvaible")
        }
    }

    private func setImagePoster(_ imageUrl: String) {
        let controller = MovieController()

        controller.getImageByUrl(urlString: imageUrl) { (image) in
            DispatchQueue.main.async {
                self.posterImage.image = image
            }
        }
    }
}
