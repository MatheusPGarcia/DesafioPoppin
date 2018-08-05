//
//  MainViewController.swift
//  Movies
//
//  Created by Matheus Garcia on 01/08/18.
//  Copyright © 2018 poppin 2018. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var moviesResponseTableView: UITableView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    
    var moviesResponse = Movies()

    override func viewDidLoad() {
        super.viewDidLoad()

        moviesResponseTableView.isHidden = true
        statusImage.image = UIImage(named: "Search")
        statusLabel.text = "Use the search bar to find a movie"
    }

    // This func is called whenever a new search is wanted by the user
    func searchForMovies(byTitle title: String) {

        let status = isInternetConnectionEstablished()
        if !status {
            self.moviesResponseTableView.isHidden = true
            self.statusLabel.isHidden = false
            self.statusImage.isHidden = false
            self.statusLabel.text = "Check your internet connection"
            self.statusImage.image = UIImage(named: "NoWifi")
            return
        }

        let controller = MovieController()
        controller.searchForMoviesByName(searchFor: title) { (movies) in
            DispatchQueue.main.async {

                guard let movies = movies else {
                    self.moviesResponseTableView.isHidden = true
                    self.statusLabel.isHidden = false
                    self.statusImage.isHidden = false
                    
                    self.statusLabel.text = "Movie not found"
                    self.statusImage.image = UIImage(named: "NoResult")
                    return
                }

                self.statusImage.isHidden = true
                self.statusLabel.isHidden = true
                self.moviesResponseTableView.isHidden = false
                
                self.moviesResponse = movies
                self.moviesResponseTableView.reloadData()
            }
        }
    }

    // This func will be responsable to intanciate a new viewController of the type details to show
    // details about the tableView's selected movie
    func presentDetails(for movie: Movie) {

        let status = isInternetConnectionEstablished()
        if !status {
            self.moviesResponseTableView.isHidden = true
            self.statusLabel.isHidden = false
            self.statusImage.isHidden = false
            self.statusLabel.text = "Check your internet connection"
            self.statusImage.image = UIImage(named: "NoWifi")
            return
        }

        let mainView = UIStoryboard(name: "Main", bundle: nil)

        // Instanciate a new viewController of type details
        let detailIdentifier = "MovieDetailsStoryboard"
        guard let destination = mainView.instantiateViewController(withIdentifier: detailIdentifier) as? MovieDetailsViewController else {
            fatalError("Unable to instantiate ViewController with identifier: \(detailIdentifier)")
        }

        destination.movieId = movie.imdbId

        self.present(destination, animated: true, completion: nil)
    }

    func isInternetConnectionEstablished() -> Bool {
        let connection = Reachability.isConnectedToNetwork()
        if connection {
            return true
        }
        return false
    }
}

// Extension to handle SearchBar activities
extension MainViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

        if let searchBarText = searchBar.text {
            searchForMovies(byTitle: searchBarText)
        }

        hideKeyboard()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        setToHideKeyboardWhenTapperAround()
    }

    func setToHideKeyboardWhenTapperAround() {

        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyboard))

        view.addGestureRecognizer(tapGesture)
    }

    @objc private func hideKeyboard() {
        searchBar.endEditing(true)

        // It's necessary to remove all gesture recognizer or the interaction with the view will be harmed
        view.gestureRecognizers?.removeAll()
    }
}

// Extension to handle tabbar operations
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesResponse.movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cellIdentifier = "MovieTableViewCell"

        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? MovieTableViewCell else {
            fatalError("Unable to dequeueReusableCell cast")
        }

        let cellMovie = moviesResponse.movies[indexPath.row]

        cell.movie = cellMovie

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let selectedMovie = moviesResponse.movies[indexPath.row]
        presentDetails(for: selectedMovie)
    }
}
