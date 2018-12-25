//
//  EventTableViewCell.swift
//  praytime
//
//  Created by Sameer on 12/24/18.
//  Copyright © 2018 praytime. All rights reserved.
//

import UIKit

protocol EventCellProtocol {
    func navigateToWebView(url: URL)
}

class EventTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var container: UIView!
    @IBOutlet private weak var titleButton: UIButton!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet weak var tableView: PrayerTableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    var delegate: EventCellProtocol?
    
    var event: Event! {
        didSet {
            titleButton.setTitle(event.name, for: UIControl.State())
            addressLabel.text = event.address
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        container.layer.cornerRadius = 5
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOpacity = 0.5
        container.layer.shadowOffset = CGSize.zero
        container.layer.shadowRadius = 1
        tableView.dataSource = self
        tableView.delegate = self
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let height = tableView.contentSize.height
        invalidate(height: height, animated: false)
    }
    
    func invalidate(height: CGFloat, animated: Bool) {
        // Bail out if we are already the right height
        if tableView.bounds.height == height { return }
        
        // Ensure unwanted layout changes don't get captured in the animation block
        layoutIfNeeded()
        
        // Make the size tableView as tall as its content
        tableViewHeight.constant = height
    }
}

extension EventTableViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return event.prayers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        if !event.prayers.isEmpty {
            cell.textLabel?.text = event.prayers[indexPath.row].name
        }
        return cell
    }
    
    
}
