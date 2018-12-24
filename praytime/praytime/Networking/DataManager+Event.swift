//
//  DataManager+Event.swift
//  praytime
//
//  Created by Sameer on 12/24/18.
//  Copyright © 2018 praytime. All rights reserved.
//

import Foundation
import CoreLocation

extension DataManager {
    
    func filterEvents(for location: String, events: [Event], completion: @escaping (_ error: Error?, _ events: [Event]?) -> ()) {
        
        findLocation(from: location) { (error, location) in
            if let error = error {
                completion(error, nil)
            }
            else if let location = location {
                let filteredEvents = events.filter {
                    return $0.distanceInMiles(from: location) < 25
                }
                let sortedEvents = filteredEvents.sorted {
                    return $0.location.distance(from: location) < $1.location.distance(from: location)
                }
                completion(nil, sortedEvents)
            }
        }
    }
    
    func filterBookmaredEvents(events: [Event]) {
        
    }
    
    private func findLocation(from string: String, completion: @escaping (_ error: Error?, _ location: CLLocation?) -> () ) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(string) { (placemarks, error) in
            if let error = error {
                completion(error, nil)
            }
            else if let placemarks = placemarks {
                let location = placemarks.first?.location
                completion(nil, location)
            }
        }
    }

}
