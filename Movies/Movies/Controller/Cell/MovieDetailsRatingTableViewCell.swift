//
//  MovieDetailsRatingTableViewCell.swift
//  Movies
//
//  Created by Matheus Garcia on 03/08/18.
//  Copyright © 2018 poppin 2018. All rights reserved.
//

import UIKit

class MovieDetailsRatingTableViewCell: UITableViewCell {

    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var rating: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
