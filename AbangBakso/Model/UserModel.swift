//
//  UserModel.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 01/11/24.
//

import Foundation
import FirebaseFirestore

struct User: Codable {
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
}
