//
//  EventsViewController.swift
//  praytime
//
//  Created by Sameer on 12/24/18.
//  Copyright © 2018 praytime. All rights reserved.
//

import UIKit

class EventsViewController: UIViewController {
    /// Filtered events that are displayed to the user
    var filteredEvents: [Event]?
    /// Table view displayed
    let tableView: UITableView = UITableView()
    /// Cache of cell heights once calculated to reload with correct estimated height
    private var cellHeights: [IndexPath: CGFloat] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DataManager.shared.delegate = self
        setupTableView()
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "EventTableViewCell", bundle: nil), forCellReuseIdentifier: "eventCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        view.addSubview(tableView)
        pinTableViewToEdges()
        tableView.isHidden = true
    }
    
    func pinTableViewToEdges(topContraintTo anchor: NSLayoutYAxisAnchor? = nil) {
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: anchor ?? view.topAnchor).isActive = true
    }
    
    func showTableView(animated: Bool = false) {
        if !animated {
            tableView.isHidden = false
        }
        else {
            UIView.animate(withDuration: 0.6) {
                self.tableView.isHidden = false
            }
        }
    }
}

extension EventsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let height = cellHeights[indexPath] else { return 200 }
        return height
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cellHeights[indexPath] = cell.frame.size.height
    }
}

extension EventsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let events = filteredEvents else { return 0 }
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventTableViewCell
        guard let events = filteredEvents else { return cell }
        cell.event = events[indexPath.row]
        cell.delegate = self
        cell.setNeedsLayout()
        return cell
    }
}

extension EventsViewController: DataManagerDelegate {
    func isloading(_ loading: Bool) {}
    
    func didReceieveFilteredEvents(events: [Event]) {
        filteredEvents = events
        DispatchQueue.main.async {
            self.tableView.reloadData()
            if self.tableView.isHidden {
                self.showTableView(animated: true)
            }
        }
    }
    
    func eventsDidFail(error: Error) {}
}

extension EventsViewController: EventView {
    func navigate(event: Event) {
        print(event)
    }
    
    func openWebView(url: URL) {
        let vc = WebViewController()
        vc.url = url
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func eventBookmarked() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
