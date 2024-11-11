//
//  GetLocationUpdates.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 11/11/24.
//

import Foundation
import Combine
import CoreLocation

protocol GetLocationUpdates: AutoMockable {
    func execute() -> AnyPublisher<CLLocationCoordinate2D, Never>
}

class GetLocationUpdatesImpl: GetLocationUpdates {
    private let repository: LocationRepository
    
    init(_ locationRepository: LocationRepository) {
        self.repository = locationRepository
    }
    func execute() -> AnyPublisher<CLLocationCoordinate2D, Never> {
        return repository.getLocationUpdates()
    }
}
