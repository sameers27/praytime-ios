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
    
    /// Event prayer info converted to array of Prayer models
    var prayers: [Prayer] {
        return getPrayers()
    }
    /// Distance of event from the location that was searched
    var distanceFromSearchedLocation: Double?
    /// CLLocation of an event from its geo
    var location: CLLocation {
        return CLLocation(latitude: geo.latitude, longitude: geo.longitude)
    }
    /// Check if event is book marked
    var bookmarked: Bool {
        return DataManager.shared.isEventBookmarked(event: self)
    }
    /// Text describing when event was last updated
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
}
