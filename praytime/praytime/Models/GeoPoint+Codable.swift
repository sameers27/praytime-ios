//
//  GeoCode+Codable.swift
//  praytime
//
//  Created by Sameer on 12/23/18.
//  Copyright © 2018 praytime. All rights reserved.
//

import Foundation
import Firebase

protocol CodableGeoPoint: Codable {
    var latitude: Double { get }
    var longitude: Double { get }
    
    init(latitude: Double, longitude: Double)
}

enum CodableGeoPointCodingKeys: CodingKey {
    case latitude, longitude
}

extension CodableGeoPoint {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodableGeoPointCodingKeys.self)
        let latitude = try container.decode(Double.self, forKey: .latitude)
        let longitude = try container.decode(Double.self, forKey: .longitude)
        
        self.init(latitude: latitude, longitude: longitude)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodableGeoPointCodingKeys.self)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
    }
}

extension GeoPoint: CodableGeoPoint {}
