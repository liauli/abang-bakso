//
//  GetLocationUpdates.swift
//  AbangBaksoTests
//
//  Created by aulia_nastiti on 13/11/24.
//

import Foundation
import XCTest
import Combine
import CoreLocation
import SwiftyMocky
@testable import AbangBakso

final class GetLocationUpdatesImplTests: XCTestCase {
    private var locationRepositoryMock: LocationRepositoryMock!
    private var getLocationUpdates: GetLocationUpdatesImpl!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        locationRepositoryMock = LocationRepositoryMock()
        getLocationUpdates = GetLocationUpdatesImpl(locationRepositoryMock)
        cancellables = []
    }

    override func tearDown() {
        locationRepositoryMock = nil
        getLocationUpdates = nil
        cancellables = nil
        super.tearDown()
    }

    func test_execute_callsRepositoryGetLocationUpdates() {
        // Arrange
        let expectedLocation = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
        Given(locationRepositoryMock, .getLocationUpdates(willReturn: Just(expectedLocation).eraseToAnyPublisher()))

        // Act
        let expectation = XCTestExpectation(description: "Should receive location update")
        getLocationUpdates.execute()
            .sink { location in
                XCTAssertEqual(location.latitude, expectedLocation.latitude)
                XCTAssertEqual(location.longitude, expectedLocation.longitude)
                expectation.fulfill()
            }
            .store(in: &cancellables)

        // Assert
        Verify(locationRepositoryMock, .getLocationUpdates())
        wait(for: [expectation], timeout: 1.0)
    }

    func test_stop_callsRepositoryStopUpdate() {
        // Act
        getLocationUpdates.stop()

        // Assert
        Verify(locationRepositoryMock, .stopUpdate())
    }
}
