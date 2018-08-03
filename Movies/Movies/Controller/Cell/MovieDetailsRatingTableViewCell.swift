//
//  MovieDetailsRatingTableViewCell.swift
//  Movies
//
//  Created by Matheus Garcia on 03/08/18.
//  Copyright © 2018 poppin 2018. All rights reserved.
//

import UIKit

class MovieDetailsRatingTableViewCell: UITableViewCell {

    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!

    var rating: Rating?

    override func layoutSubviews() {

        guard let rating = rating else { return }

        authorLabel.text = rating.source
        ratingLabel.text = rating.value
    }
}
