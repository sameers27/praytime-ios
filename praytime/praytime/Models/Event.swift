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

class Event: Codable {
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
    
    var distanceFromSearchedLocation: Double?
    
    var location: CLLocation {
        return CLLocation(latitude: geo.latitude, longitude: geo.longitude)
    }
    
    var bookmarked: Bool {
        return DataManager.shared.isEventBookmarked(event: self)
    }
    
    var prayers: [Prayer] {
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
    
    var lastUpdatedText: String? {
        let calendarUnits: Set = [Calendar.Component.weekOfMonth, Calendar.Component.day, Calendar.Component.hour, Calendar.Component.minute, Calendar.Component.second]
        let dateComponents = Calendar.current.dateComponents(calendarUnits, from: crawlTime.dateValue(), to: Date())
        
        let timeAgo = getTimeString(time: dateComponents.weekOfMonth, string: "Week")
            ?? getTimeString(time: dateComponents.day, string: "Day")
            ?? getTimeString(time: dateComponents.hour, string: "Hour")
            ?? getTimeString(time: dateComponents.minute, string: "Minute")
            ?? getTimeString(time: dateComponents.second, string: "Second")
            ?? nil
        
        guard let time = timeAgo else { return nil }
        return "Last Updated " + time
    }
    
    private func getTimeString(time: Int?, string: String) -> String? {
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
