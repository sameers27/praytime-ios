//
//  EventTableViewCell.swift
//  praytime
//
//  Created by Sameer on 12/24/18.
//  Copyright © 2018 praytime. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var container: UIView!
    @IBOutlet private weak var titleButton: UIButton!
    
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var fajrLabel: UILabel!
    @IBOutlet weak var zuhrLabel: UILabel!
    @IBOutlet weak var asrLabel: UILabel!
    @IBOutlet weak var maghribLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    var event: Event! {
        didSet {
            titleButton.setTitle(event.name, for: UIControl.State())
            addressLabel.text = event.address
            fajrLabel.text = event.fajrIqama
            zuhrLabel.text = event.zuhrIqama
            asrLabel.text = event.asrIqama
            maghribLabel.text = event.maghribIqama
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        container.layer.cornerRadius = 5
        container.layer.shadowColor = UIColor.black.cgColor
        container.layer.shadowOpacity = 0.5
        container.layer.shadowOffset = CGSize.zero
        container.layer.shadowRadius = 1
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stackView.arrangedSubviews.forEach {
            $0.isHidden = false
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        stackView.arrangedSubviews.forEach {
            guard let label = $0 as? UILabel else { return }
            $0.isHidden = label.text == nil
        }
    }
}
