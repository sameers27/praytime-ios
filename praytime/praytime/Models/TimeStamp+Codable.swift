//
//  FIRTimeStamp+Codable.swift
//  praytime
//
//  Created by Sameer on 12/24/18.
//  Copyright © 2018 praytime. All rights reserved.
//

import Foundation
import Firebase

protocol CodableTimeStamp: Codable {
    var seconds: Int64 { get }
    var nanoseconds: Int32 { get }
    
    init(seconds: Int64, nanoseconds: Int32)
}

enum CodableTimeStampCodingKeys: CodingKey {
    case seconds, nanoseconds
}

extension CodableTimeStamp {
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodableTimeStampCodingKeys.self)
        let seconds = try container.decode(Int64.self, forKey: .seconds)
        let nanoseconds = try container.decode(Int32.self, forKey: .nanoseconds)
        
        self.init(seconds: seconds, nanoseconds: nanoseconds)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodableTimeStampCodingKeys.self)
        try container.encode(seconds, forKey: .seconds)
        try container.encode(nanoseconds, forKey: .nanoseconds)
    }
}

extension Timestamp: CodableTimeStamp {}
