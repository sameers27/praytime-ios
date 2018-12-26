//
//  BookmarksViewController.swift
//  praytime
//
//  Created by Sameer on 12/25/18.
//  Copyright © 2018 praytime. All rights reserved.
//

import UIKit

class BookmarksViewController: EventsViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Bookmarks"
        
        
        getEvents { (error, events) in
            if let events = events {
                self.filteredEvents = DataManager.shared.filterBookmaredEvents(events: events)
                self.tableView.reloadData()
                if self.tableView.isHidden {
                    self.tableView(isHidden: false, animated: true)
                }
            }
        }
    }
    
    override func eventBookmarked() {
        guard let events = events else { return }
        self.filteredEvents = DataManager.shared.filterBookmaredEvents(events: events)
        self.tableView.reloadData()
    }
    
    
}
