//
//  MovieDetailsViewController.swift
//  Movies
//
//  Created by Matheus Garcia on 01/08/18.
//  Copyright © 2018 poppin 2018. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    @IBOutlet weak var detailsTableView: UITableView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    
    var movieId: String?
    var movie: MovieDetails?
    var movieInfo = [(String, String?)]()
    var ratings = [Rating]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let movieId = movieId {
            let controller = MovieController()
            controller.searchForDetailsById(searchFor: movieId) { (movieDetails) in
                self.movie = movieDetails
                self.updateInfo()
            }
        }
    }

    func updateInfo() {

        guard let movie = movie else { return }

        DispatchQueue.main.async {
            self.movieTitleLabel.text = movie.title
            self.setImage(movie)
            self.ratings = movie.ratings
            self.createMovieInfoArray()
            self.detailsTableView.reloadData()
        }
    }

    func setImage(_ movie: MovieDetails) {

        guard let imageUrl = movie.imageUrl else {

            let image = UIImage(named: "NoImageAvaible")
            self.movieImageView.image = image
            return
        }

        let controller = MovieController()
        controller.getImageByUrl(urlString: imageUrl) { (image) in
            DispatchQueue.main.async {
                self.movieImageView.image = image
            }
        }
    }

    // Choose this way to work with the information so I can show everything in an only type of uiTableViewCell
    func createMovieInfoArray() {
        guard let movie = movie else { return }

        let released = ("Released:", movie.released)
        let rated = ("Rated:", movie.rated)
        let genre = ("Genre:", movie.genre)
        let director = ("Director:", movie.director)
        let writer = ("Writer:", movie.writer)
        let plot = ("Plot:", movie.plot)

        movieInfo.append(released)
        movieInfo.append(rated)
        movieInfo.append(genre)
        movieInfo.append(director)
        movieInfo.append(writer)
        movieInfo.append(plot)
    }
    
    @IBAction func goBackWasPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension MovieDetailsViewController: UITableViewDelegate, UITableViewDataSource {

    // Section About and section Rating
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    // Setting the title of the header
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let identifier = "MovieDetailsHeaderTableViewCell"

        guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? MovieDetailsHeaderTableViewCell else { return UITableViewCell() }

        switch section {
        case 0:
            cell.titleLabel.text = "About"
            return cell
        case 1:
            cell.titleLabel.text = "Ratings"
            return cell
        default:
            cell.titleLabel.text = "Header not expected"
            return cell
        }
    }

    // Setting the number of rows for each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return movieInfo.count
        } else {
            return ratings.count
        }
    }

    // Setting the cell according to its section
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0:

            let identifier = "MovieDetailsInfoTableViewCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? MovieDetailsInfoTableViewCell else { return UITableViewCell() }

            let info = movieInfo[indexPath.row]

            cell.keyLabel.text = info.0

            if let value = info.1 {
                cell.valueLabel.text = value
            } else {
                cell.valueLabel.text = "Information not provided by the API"
            }

            return cell
        case 1:

            let identifier = "MovieDetailsRatingTableViewCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? MovieDetailsRatingTableViewCell else { return UITableViewCell() }

            let rating = ratings[indexPath.row]

            cell.authorLabel.text = rating.source
            cell.ratingLabel.text = rating.value

            return cell
        default:
            return UITableViewCell()
        }
    }
}
