//
//  MovieDetailsHeaderTableViewCell.swift
//  Movies
//
//  Created by Matheus Garcia on 03/08/18.
//  Copyright © 2018 poppin 2018. All rights reserved.
//

import UIKit

class MovieDetailsHeaderTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!

    var title: String?

    override func layoutSubviews() {

        if let title = title {
            titleLabel.text = title
        } else {
            titleLabel.text = ""
        }
    }
}
