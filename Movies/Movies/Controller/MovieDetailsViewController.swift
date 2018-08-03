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
        }
    }

    func setImage(_ movie: MovieDetails) {
        guard let imageUrl = movie.imageUrl else { return }

        let controller = MovieController()
        controller.getImageByUrl(urlString: imageUrl) { (image) in
            DispatchQueue.main.async {
                self.movieImageView.image = image
            }
        }
    }
    
    @IBAction func goBackWasPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension MovieDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
