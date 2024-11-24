//
//  UserModel.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 01/11/24.
//

import Foundation
import CoreLocation

struct User: Equatable, Identifiable {
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.name == rhs.name &&
        lhs.location.latitude == rhs.location.latitude &&
        lhs.location.longitude == rhs.location.longitude &&
        lhs.lastActive == rhs.lastActive &&
        lhs.isActive == rhs.isActive &&
        lhs.type == rhs.type
    }
    
    var id: String

    let type: Collection

    // MARK: from Firebase
    let name: String
    var location: CLLocationCoordinate2D
    var lastActive: Date
    var isActive: Bool

    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: location.latitude, longitude: location.longitude)
    }

    var dictionary: [String: Any] {
      return [
        "name": name,
        "location": [
            "latitude": location.latitude,
            "longitude": location.longitude
        ],
        "lastActive": lastActive.timeIntervalSince1970,
        "isActive": isActive
      ]
    }

    init(type: Collection, _ dict: [String: Any]) {
        
        name = dict["name"] as? String ?? ""
        id = name
        self.type = type
        
        let locationData = dict["location"] as? [String: Double] ?? [:]
        location = CLLocationCoordinate2D(
            latitude: locationData["latitude"] ?? 0,
            longitude: locationData["longitude"] ?? 0
        )
        
        if let timeInSec = dict["lastActive"] as? Int64 {
            lastActive = Date(timeIntervalSince1970: TimeInterval(timeInSec))
        } else {
            lastActive = Date()
        }
        
        isActive = dict["isActive"] as? Bool ?? false
    }

    init(
        type: Collection,
        name: String,
        location: CLLocationCoordinate2D,
        lastActive: Date,
        isActive: Bool
    ) {
        self.type = type
        self.name = name
        self.id = name
        self.location = location
        self.lastActive = lastActive
        self.isActive = isActive
    }
}

extension User: Codable {
    enum CodingKeys: String, CodingKey {
           case id, type, name, location, lastActive, isActive
    }

    enum LocationKeys: String, CodingKey {
        case latitude, longitude
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        type = try container.decode(Collection.self, forKey: .type)
        name = try container.decode(String.self, forKey: .name)
        isActive = try container.decode(Bool.self, forKey: .isActive)
        lastActive = try container.decode(Date.self, forKey: .lastActive)
        
        // Decode nested location
        let locationContainer = try container.nestedContainer(keyedBy: LocationKeys.self, forKey: .location)
        let latitude = try locationContainer.decode(CLLocationDegrees.self, forKey: .latitude)
        let longitude = try locationContainer.decode(CLLocationDegrees.self, forKey: .longitude)
        location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(type, forKey: .type)
        try container.encode(name, forKey: .name)
        try container.encode(isActive, forKey: .isActive)
        try container.encode(lastActive, forKey: .lastActive)
        
        // Encode nested location
        var locationContainer = container.nestedContainer(keyedBy: LocationKeys.self, forKey: .location)
        try locationContainer.encode(location.latitude, forKey: .latitude)
        try locationContainer.encode(location.longitude, forKey: .longitude)
    }
}
