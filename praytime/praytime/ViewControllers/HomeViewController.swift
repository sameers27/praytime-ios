//
//  HomeViewController.swift
//  praytime
//
//  Created by Sameer on 12/23/18.
//  Copyright © 2018 praytime. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    var events: [Event]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        DataManager.shared.getEvents { (error, events) in
            if let error = error {
                print("There was an error: \(error.localizedDescription)")
            }
            else if let events = events {
                self.events = events
                self.tableView.reloadData()
            }
        }

    }
}

extension HomeViewController: UITableViewDelegate {
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let events = events else { return 0 }
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)//tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let events = events else { return cell }
        cell.textLabel?.text = events[indexPath.row].name
        return cell
    }
}
