//
//  UserModel.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 01/11/24.
//

import Foundation
import FirebaseFirestore
import CoreLocation

struct User: Codable, Equatable, Identifiable {
    var id: String

    let type: Collection

    // MARK: from Firestore
    let name: String
    var location: GeoPoint
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
        location = GeoPoint(
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
        location: GeoPoint,
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
