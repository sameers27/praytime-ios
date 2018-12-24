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
    let fajr: String?
    let fajrIqamaModified: Timestamp?
    let zuhr: String?
    let zuhrIqamaModified: Timestamp?
    let asr: String?
    let asrIqamaModified: Timestamp?
    let maghrib: String?
    let maghribIqamaModified: Timestamp?
    let isha: String?
    let ishaIqamaModified: Timestamp?
    let juma1: String?
    let juma1IqamaModified: Timestamp?
    let juma2: String?
    let juma2IqamaModified: Timestamp?
    let juma3: String?
    let juma3IqamaModified: Timestamp?
    
    var location: CLLocation {
        return CLLocation(latitude: geo.latitude, longitude: geo.longitude)
    }
    
    func distanceInMiles(from location: CLLocation) -> Double {
        let distance = self.location.distance(from: location)
        return distance / 1609.344
    }
}
