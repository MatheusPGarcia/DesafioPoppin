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
    
    var moviesResponse = Movies()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    // This func is called whenever a new search is wanted by the user
    func searchForMovies(byTitle title: String) {
        let controller = MovieController()
        controller.searchForMoviesByName(searchFor: title) { (movies) in
            DispatchQueue.main.async {
                self.moviesResponse = movies
                self.moviesResponseTableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

        cell.name = cellMovie.title
        cell.year = cellMovie.year

        return cell
    }
}
