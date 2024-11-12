//
//  UserModel.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 01/11/24.
//

import Foundation
import FirebaseFirestore

struct User: Codable, Equatable, Identifiable {
    var id: String
    
    let type: Collection
    
    // MARK: from Firestore
    let name: String
    var location: GeoPoint
    var lastActive: Timestamp
    var isActive: Bool
    
    var dictionary: [String: Any] {
      return [
        "name": name,
        "location": location,
        "lastActive": lastActive,
        "isActive": isActive
      ]
    }
    
    init(type: Collection, _ dict: [String: Any]) {
        name = dict["name"] as? String ?? ""
        id = name
        self.type = type
        location = dict["location"] as? GeoPoint ?? GeoPoint(latitude: 0, longitude: 0)
        lastActive = dict["lastActive"] as? Timestamp ?? Timestamp(date: Date())
        isActive = dict["isActive"] as? Bool ?? false
    }
    
    init(
        type: Collection,
        name: String,
        location: GeoPoint,
        lastActive: Timestamp,
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
