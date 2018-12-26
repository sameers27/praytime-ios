//
//  EventTableViewCell.swift
//  praytime
//
//  Created by Sameer on 12/24/18.
//  Copyright © 2018 praytime. All rights reserved.
//

import UIKit

protocol EventView {
    /// Navigate the user to the event location
    func navigate(event: Event)
    /// Open a webview with a given url
    func openWebView(url: URL)
    /// Event has been bookmarked
    func eventBookmarked()
}

class EventTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var container: UIView!
    @IBOutlet private weak var addressLabel: UILabel!
    @IBOutlet private weak var stackView: UIStackView!
    @IBOutlet private weak var updatedLabel: UILabel!
    @IBOutlet private weak var bookmarkButton: UIButton!
    
    var delegate: EventView?
    
    var event: Event! {
        didSet {
            titleLabel.text = event.name
            addressLabel.text = event.address
            updatedLabel.text = event.lastUpdatedText
            setBookmarkedImage()
            populateStackView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        container.layer.cornerRadius = 5
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOpacity = 0.5
        container.layer.shadowOffset = CGSize.zero
        container.layer.shadowRadius = 1
        selectionStyle = .none
        titleLabel.textColor = UIColor(named: "PrayTimeBlue")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        addressLabel.text = nil
        titleLabel.text = nil
        stackView.removeAllArrangedSubviews()
    }
    
    @IBAction func titlePressed(_ sender: Any) {
        guard let url = event.url else { return }
        delegate?.openWebView(url: url)
    }
    
    @IBAction func reportAnErrorPressed(_ sender: Any) {
        let urlString = "https://gitreports.com/issue/praytime/praytime?issue_title="
        let path = "\(event.name) ref:\(event.uuid4)"
        let escapedPath = path.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        guard let percentEncoded = escapedPath else { return }
        guard let url = URL(string: urlString + percentEncoded) else { return }
        delegate?.openWebView(url: url)
    }
    
    func setBookmarkedImage() {
        if event.bookmarked {
            bookmarkButton.setImage(UIImage.init(named: "bookmarkFilled"), for: UIControl.State())
        }
        else {
            bookmarkButton.setImage(UIImage.init(named: "bookmarkUnfilled"), for: UIControl.State())
        }
    }
    
    @IBAction func bookmarkPressed(_ sender: Any) {
        if event.bookmarked {
            DataManager.shared.removeBookmark(event: event)
        }
        else {
            DataManager.shared.bookmarkEvent(event: event)
        }
        delegate?.eventBookmarked()
    }
    
    func populateStackView() {
        let eventInfo = EventInfoStackView(event: event)
        eventInfo.delegate = self
        stackView.addArrangedSubview(eventInfo)
        if event.prayers.isEmpty {
            stackView.addArrangedSubview(EmptyPrayerLineItem())
        }
        else {
            event.prayers.forEach {
                let lineItem: PrayerLineItem = .fromNib()
                lineItem.prayer = $0
                stackView.addArrangedSubview(lineItem)
            }
        }
    }
}

extension EventTableViewCell: EventInfo {
    func navigate() {
        delegate?.navigate(event: event)
    }
}
