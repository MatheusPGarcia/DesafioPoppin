//
//  MovieDetailsInfoTableViewCell.swift
//  Movies
//
//  Created by Matheus Garcia on 03/08/18.
//  Copyright © 2018 poppin 2018. All rights reserved.
//

import UIKit

class MovieDetailsInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!

    var detail: (String, String?)?

    override func layoutSubviews() {

        guard let detail = detail else { return }

        keyLabel.text = detail.0

        if let value = detail.1 {
            valueLabel.text = value
        } else {
            valueLabel.text = "Information not provided by the API"
        }
    }
}
