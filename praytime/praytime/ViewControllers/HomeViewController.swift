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
    
    private let search = UISearchController(searchResultsController: SearchResultsTableViewController())
    private var headerTitle: String?

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
        
        getEvents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerTitle = headerTitle else { return nil }
        return SearchHeader(title: headerTitle)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 100
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
        headerTitle = title
        tableView.reloadData()
        search.dismiss(animated: true, completion: nil)
        search.searchBar.text = nil
        
        guard let events = events else { return }
        
        DataManager.shared.filterEvents(for: title, events: events) { (error, events) in
            if let error = error {
                print("There was an error: \(error.localizedDescription)")
            }
            else if let events = events {
                self.filteredEvents = events
                self.tableView.reloadData()
                if self.tableView.isHidden {
                    self.tableView(isHidden: false, animated: true)
                }
            }
        }
        
    }
}

extension HomeViewController {
    struct Strings {
        static let title = "praytime.app"
        static let searchPlaceholder = "Enter a location"
    }
}
