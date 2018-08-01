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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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
            // TODO: Handle search
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
