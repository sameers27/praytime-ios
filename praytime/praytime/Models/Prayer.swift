//
//  Prayer.swift
//  praytime
//
//  Created by Sameer on 12/25/18.
//  Copyright © 2018 praytime. All rights reserved.
//

import Foundation
import Firebase


struct Prayer {
    let name: String
    let displayTime: String
    let lastModified: Timestamp?
    
    var shouldHighlight: Bool {
        guard let lastModified = lastModified else { return false }
        if let diff = Calendar.current.dateComponents([.hour], from: lastModified.dateValue(), to: Date()).hour, diff < 48 {
            return true
        }
        return false
    }
}
