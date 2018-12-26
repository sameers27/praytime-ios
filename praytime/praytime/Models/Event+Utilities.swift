//
//  Event+Prayer.swift
//  praytime
//
//  Created by Sameer on 12/26/18.
//  Copyright © 2018 praytime. All rights reserved.
//

import UIKit
import CoreLocation

extension Event {
    func getPrayers() -> [Prayer] {
        var arr: [Prayer] = []
        if let fajr = fajrIqama {
            arr.append(Prayer(name: "Fajr", displayTime: fajr, lastModified: fajrIqamaModified))
        }
        if let zuhr = zuhrIqama {
            arr.append(Prayer(name: "Zuhr", displayTime: zuhr, lastModified: zuhrIqamaModified))
        }
        if let asr = asrIqama {
            arr.append(Prayer(name: "Asr", displayTime: asr, lastModified: asrIqamaModified))
        }
        if let maghrib = maghribIqama {
            arr.append(Prayer(name: "Maghrib", displayTime: maghrib, lastModified: maghribIqamaModified))
        }
        if let isha = ishaIqama {
            arr.append(Prayer(name: "Isha", displayTime: isha, lastModified: ishaIqamaModified))
        }
        if let juma = juma1 {
            arr.append(Prayer(name: "Juma", displayTime: juma, lastModified: juma1Modified))
        }
        if let juma = juma2 {
            arr.append(Prayer(name: "Juma", displayTime: juma, lastModified: juma2Modified))
        }
        if let juma = juma3 {
            arr.append(Prayer(name: "Juma", displayTime: juma, lastModified: juma3Modified))
        }
        
        return arr
    }
    
    func distanceInMiles(from location: CLLocation) -> Double {
        let distance = self.location.distance(from: location)
        let miles = distance / 1609.344
        distanceFromSearchedLocation = miles
        return miles
    }
    
    func getTimeString(time: Int?, string: String) -> String? {
        guard let time = time else { return nil }
        if time > 1 {
            return "\(time) \(string)s Ago"
        }
        else if time == 1 {
            return "\(time) \(string) Ago"
        }
        
        return nil
    }
}
