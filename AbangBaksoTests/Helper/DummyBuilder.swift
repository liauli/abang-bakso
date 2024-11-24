//
//  DummyBuilder.swift
//  AbangBaksoTests
//
//  Created by aulia_nastiti on 05/11/24.
//

import Foundation
import CoreLocation

@testable import AbangBakso

enum DummyBuilder {
    static func createUser(type: Collection, name: String = "Nama") -> User {
        return User(
            type: type,
            name: name,
            location: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0),
            lastActive: Date(),
            isActive: false
        )
    }
}
