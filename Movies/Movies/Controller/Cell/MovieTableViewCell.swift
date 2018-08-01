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

    var name: String?
    var year: String?

    override func layoutSubviews() {

        if let name = name {
            titleLabel.text = name
        } else {
            titleLabel.text = "Title not provided by the api"
        }

        if let year = year {
            yearLabel.text = year
        } else {
            yearLabel.text = "Year not provided by the api"
        }
    }

}
