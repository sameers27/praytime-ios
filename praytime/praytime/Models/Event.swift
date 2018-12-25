//
//  Event.swift
//  praytime
//
//  Created by Sameer on 12/23/18.
//  Copyright © 2018 praytime. All rights reserved.
//

import Foundation
import Firebase
import CoreLocation

struct Event: Codable {
    let name: String
    let url: URL?
    let address: String?
    let geo: GeoPoint
    let uuid4: String
    let crawlTime: Timestamp
    let timeZoneId: String
    let fajrIqama: String?
    let fajrIqamaModified: Timestamp?
    let zuhrIqama: String?
    let zuhrIqamaModified: Timestamp?
    let asrIqama: String?
    let asrIqamaModified: Timestamp?
    let maghribIqama: String?
    let maghribIqamaModified: Timestamp?
    let ishaIqama: String?
    let ishaIqamaModified: Timestamp?
    let juma1: String?
    let juma1Modified: Timestamp?
    let juma2: String?
    let juma2Modified: Timestamp?
    let juma3: String?
    let juma3Modified: Timestamp?
    
    var location: CLLocation {
        return CLLocation(latitude: geo.latitude, longitude: geo.longitude)
    }
    
    var prayers: [Prayer] {
        var arr: [Prayer] = []
        if let fajr = fajrIqama, let fajrModified = fajrIqamaModified {
            arr.append(Prayer(name: "Fajr", displayTime: fajr, lastModified: fajrModified))
        }
        if let zuhr = zuhrIqama, let zuhrModified = zuhrIqamaModified {
            arr.append(Prayer(name: "Zuhr", displayTime: zuhr, lastModified: zuhrModified))
        }
        if let asr = asrIqama, let asrModified = asrIqamaModified {
            arr.append(Prayer(name: "Asr", displayTime: asr, lastModified: asrModified))
        }
        if let maghrib = maghribIqama, let maghribModified = maghribIqamaModified {
            arr.append(Prayer(name: "Maghrib", displayTime: maghrib, lastModified: maghribModified))
        }
        if let isha = ishaIqama, let ishaModified = ishaIqamaModified {
            arr.append(Prayer(name: "Isha", displayTime: isha, lastModified: ishaModified))
        }
        if let juma = juma1, let jumaModified = juma1Modified {
            arr.append(Prayer(name: "Juma", displayTime: juma, lastModified: jumaModified))
        }
        if let juma = juma2, let jumaModified = juma2Modified {
            arr.append(Prayer(name: "Juma", displayTime: juma, lastModified: jumaModified))
        }
        if let juma = juma3, let jumaModified = juma3Modified {
            arr.append(Prayer(name: "Juma", displayTime: juma, lastModified: jumaModified))
        }
        
        return arr
    }
    
    func distanceInMiles(from location: CLLocation) -> Double {
        let distance = self.location.distance(from: location)
        return distance / 1609.344
    }
}
