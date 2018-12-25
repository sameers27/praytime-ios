//
//  EventsViewController.swift
//  praytime
//
//  Created by Sameer on 12/24/18.
//  Copyright © 2018 praytime. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController {
    var events: [Event]?
    let tableView: UITableView = UITableView()
    var isFavorites: Bool =  false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: "eventCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        pinTableViewToEdges()
        tableView(isHidden: true)
        getEvents()
    }
    
    func getEvents() {
        DataManager.shared.getEvents { (error, events) in
            if let error = error {
                print("There was an error: \(error.localizedDescription)")
            }
            else if let events = events {
                self.events = events
            }
        }
    }
    
    func pinTableViewToEdges(topContraintTo anchor: NSLayoutYAxisAnchor? = nil) {
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: anchor ?? view.topAnchor).isActive = true
    }
    
    func tableView(isHidden: Bool, animated: Bool = false) {
        if !animated {
            tableView.isHidden = isHidden
        }
        else {
            UIView.animate(withDuration: 0.3) {
                self.tableView.isHidden = isHidden
            }
        }
    }
}

extension EventsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

extension EventsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let events = events else { return 0 }
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventTableViewCell
        guard let events = events else { return cell }
        cell.event = events[indexPath.row]
        cell.setNeedsLayout()
        return cell
    }
}
