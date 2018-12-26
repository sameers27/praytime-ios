//
//  EventInfoStackView.swift
//  praytime
//
//  Created by Sameer on 12/25/18.
//  Copyright © 2018 praytime. All rights reserved.
//

import UIKit

protocol EventInfo {
    func navigate()
}

/// Stack View shown in EventTableViewCell showing distance, sunrise, and sunset times.
class EventInfoStackView: UIStackView {
    
    private var event: Event!
    
    var delegate: EventInfo?
    
    init(event: Event) {
        self.event = event
        super.init(frame: .zero)
        axis = .horizontal
        distribution = .fillProportionally
        addNavigationButton()
        addLabels()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addNavigationButton() {
        guard let distance = event.distanceFromSearchedLocation else { return }
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "map"), for: UIControl.State())
        button.setTitleColor(UIColor(named: "PrayTimeBlue"), for: UIControl.State())
        button.setTitle(String(format: "%.2f", distance), for: UIControl.State())
        button.tintColor = UIColor(named: "PrayTimeBlue")
        button.addTarget(self, action: #selector(navigate), for: .touchUpInside)
        addArrangedSubview(button)
    }
    
    private func addLabels() {
        let sunrise = UILabel()
        sunrise.text = "|  ☀️ ⬆️ 7:19 AM"
        addArrangedSubview(sunrise)
        let sunset = UILabel()
        sunset.text = "|  ☀️ ⬇️ 4:28 PM"
        addArrangedSubview(sunset)
    }
    
    private func addSeperator() {
        let label = UILabel()
        label.text = "|"
        addArrangedSubview(label)
    }
    
    @objc private func navigate() {
        delegate?.navigate()
    }
}


