//
//  EventTableViewCell.swift
//  praytime
//
//  Created by Sameer on 12/24/18.
//  Copyright © 2018 praytime. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var titleButton: UIButton!
    
    var event: Event! {
        didSet {
            titleButton.setTitle(event.name, for: UIControl.State())
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
}
