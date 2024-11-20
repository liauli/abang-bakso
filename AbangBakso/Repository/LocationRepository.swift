//
//  LocationRepository.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 11/11/24.
//

import Foundation
import CoreLocation
import Combine

protocol LocationRepository: AutoMockable {
    func getLocationUpdates() -> AnyPublisher<CLLocationCoordinate2D, Never>
    func stopUpdate()
}

final class LocationRepositoryImpl: NSObject, LocationRepository, CLLocationManagerDelegate {

    private let manager = CLLocationManager()
    private let locationSubject = PassthroughSubject<CLLocationCoordinate2D, Never>()

    var locationPublisher: AnyPublisher<CLLocationCoordinate2D, Never> {
        locationSubject.eraseToAnyPublisher()
    }

    override init() {
        super.init()
        manager.delegate = self

    }

    func checkLocationAuthorization() {
        manager.startUpdatingLocation()

        switch manager.authorizationStatus {
        case .notDetermined:
            manager.requestWhenInUseAuthorization()

        case .restricted:
            log("Location restricted")

        case .denied:
            log("Location denied")

        case .authorizedAlways, .authorizedWhenInUse:
            log("Location authorized")
            if let initialLocation = manager.location?.coordinate {
                log("location! \(initialLocation)")
                locationSubject.send(initialLocation)
            }

        @unknown default:
            log("Location service disabled")
        }
    }

    internal func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }

    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first?.coordinate {
            log("location! 2 \(location)")
            locationSubject.send(location)
        }
    }

    func getLocationUpdates() -> AnyPublisher<CLLocationCoordinate2D, Never> {
        checkLocationAuthorization()
        manager.startUpdatingLocation()

        return locationPublisher
    }

    func stopUpdate() {
        manager.stopUpdatingLocation()
    }
}
