//
//  PrayerLineItem.swift
//  praytime
//
//  Created by Sameer on 12/25/18.
//  Copyright © 2018 praytime. All rights reserved.
//

import UIKit

class PrayerLineItem: UIView {

    @IBOutlet weak var leadingLabel: UILabel!
    @IBOutlet weak var trailingLabel: UILabel!
    
    var prayer: Prayer? {
        didSet {
            leadingLabel.text = prayer?.name
            trailingLabel.text = prayer?.displayTime
            if let prayer = prayer, prayer.shouldHighlight {
                leadingLabel.textColor = .cyan
                trailingLabel.textColor = .cyan
            }
        }
    }
}
