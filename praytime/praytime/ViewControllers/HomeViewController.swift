//
//  HomeViewController.swift
//  praytime
//
//  Created by Sameer on 12/23/18.
//  Copyright © 2018 praytime. All rights reserved.
//

import UIKit
import CoreLocation

class HomeViewController: EventsViewController {
    
    let search = UISearchController(searchResultsController: SearchResultsTableViewController())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = Strings.title
        

        search.searchBar.placeholder = Strings.searchPlaceholder
        search.searchResultsUpdater = self
        definesPresentationContext = true
        navigationItem.searchController = search
        
        let searchController = search.searchResultsController as! SearchResultsTableViewController
        searchController.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = true
    }
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        let vc = search.searchResultsController as! SearchResultsTableViewController
        vc.update(text: text)
    }
}

extension HomeViewController: SearchResultsDelegate {
    func didSelectLocation(title: String) {
        search.dismiss(animated: true, completion: nil)
        search.searchBar.text = title
        
        guard let events = events else { return }
        DataManager.shared.filterEvents(for: title, events: events) { (error, events) in
            if let error = error {
                print("There was an error: \(error.localizedDescription)")
            }
            else if let events = events {
                self.events = events
                self.tableView.reloadData()
                if self.tableView.isHidden {
                    self.showTableView(animated: true)
                }
            }
        }
    }
    
}

extension HomeViewController {
    struct Strings {
        static let title = "praytime.app"
        static let searchPlaceholder = "Enter a location to search Iqama times"
    }
}



