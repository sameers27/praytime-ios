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
        title = Strings.title
        
        DataManager.shared.filterBookmaredEvents()
    }
    
    override func eventBookmarked() {
        DataManager.shared.filterBookmaredEvents()
    }
}

extension BookmarksViewController {
    struct Strings {
        static let title = "Bookmarks"
    }
}
