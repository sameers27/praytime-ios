//
//  PrayerTableView.swift
//  praytime
//
//  Created by Sameer on 12/25/18.
//  Copyright © 2018 praytime. All rights reserved.
//

import UIKit

class PrayerTableView: UITableView {

    override var intrinsicContentSize: CGSize {
        layoutIfNeeded()
        return contentSize
    }
    
    override var contentSize: CGSize {
        didSet{
            invalidateIntrinsicContentSize()
        }
    }
    
    override func reloadData() {
        super.reloadData()
        invalidateIntrinsicContentSize()
    }

}
