//
//  EmptyPrayerLineItem.swift
//  praytime
//
//  Created by Sameer on 12/25/18.
//  Copyright © 2018 praytime. All rights reserved.
//

import UIKit

class EmptyPrayerLineItem: UIView {

    init() {
        super.init(frame: .zero)
        addEmptyLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addEmptyLabel() {
        let label = UILabel()
        label.text = Strings.noTimings
        label.font = UIFont.italicSystemFont(ofSize: 17)
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: topAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 16).isActive = true
    }
}

extension EmptyPrayerLineItem {
    struct Strings {
        static let noTimings = "Check website for prayer times."
    }
}
