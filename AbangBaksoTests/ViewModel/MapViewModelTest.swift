//
//  MapViewModelTest.swift
//  AbangBaksoTests
//
//  Created by aulia_nastiti on 14/11/24.
//

import Foundation
import XCTest
import Combine
import CoreLocation
import SwiftyMocky
import FirebaseFirestore

@testable import AbangBakso

final class MapViewModelTests: XCTestCase {
    private var viewModel: MapViewModel!
    private var observeUserMock: ObserveUserMock!
    private var updateUserMock: UpdateUserMock!
    private var deleteUserMock: DeleteUserMock!
    private var observeLocationMock: GetLocationUpdatesMock!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()

        observeUserMock = ObserveUserMock()
        updateUserMock = UpdateUserMock()
        deleteUserMock = DeleteUserMock()
        observeLocationMock = GetLocationUpdatesMock()

        viewModel = MapViewModel(observeUserMock, updateUserMock, deleteUserMock, observeLocationMock)
        cancellables = []
    }

    override func tearDown() {
        observeUserMock = nil
        updateUserMock = nil
        deleteUserMock = nil
        observeLocationMock = nil
        viewModel = nil
        cancellables = nil
        super.tearDown()
    }

    func test_startObservingCustomers_updatesCustomersList() {
        // Arrange
        let users = [DummyBuilder.createUser(type: .customer)]
        Given(observeUserMock, .execute(willReturn: alwaysSuccess(users)))

        // Act
        viewModel.startObservingCustomers()

        // Assert
        XCTAssertEqual(viewModel.customers, users)
        Verify(observeUserMock, .execute())
    }

    func test_startObservingLocation_updatesUserLocationIfMoved() {
        // Arrange
        let initialLocation = GeoPoint(latitude: 0, longitude: 0)
        let newLocation = CLLocationCoordinate2D(latitude: 0.0001, longitude: 0.0001)

        viewModel.user = User(
            type: .seller,
            name: "Seller",
            location: initialLocation,
            lastActive: Timestamp(),
            isActive: true)

        Given(observeLocationMock, .execute(willReturn: Just(newLocation).eraseToAnyPublisher()))
        Given(
            updateUserMock,
                .execute(
                    user: .any,
                    willReturn:
                        Just(()).setFailureType(to: FirestoreError.self)
                        .eraseToAnyPublisher()
                )
        )

        // Act
        viewModel.startObservingLocation()

        // Assert
        Verify(observeLocationMock, .execute())
        Verify(updateUserMock, .execute(user: .any))

        XCTAssertEqual(viewModel.user?.location.latitude, newLocation.latitude)
        XCTAssertEqual(viewModel.user?.location.longitude, newLocation.longitude)
    }

    func test_stopObserving_callsStopOnObservers() {
        // Act
        viewModel.stopObserving()

        // Assert
        Verify(observeUserMock, .stop())
        Verify(observeLocationMock, .stop())
    }

    func test_updateUserData_callsUpdateUser() {
        // Arrange
        let user = DummyBuilder.createUser(type: .customer)
        viewModel.user = user
        Given(updateUserMock, .execute(user: .any, willReturn: success(())))

        // Act
        viewModel.updateUserData()

        // Assert
        Verify(updateUserMock, .execute(user: .any))
    }

    func test_setOnline_updatesUserAndCallsUpdateUser() {
        // Arrange
        let user = DummyBuilder.createUser(type: .seller)
        viewModel.user = user
        Given(
            updateUserMock,
            .execute(
                user: .any,
                willReturn: Just(()).setFailureType(
                    to: FirestoreError.self).eraseToAnyPublisher()
            )
        )

        // Act
        viewModel.setOnline(true)

        // Assert
        XCTAssertTrue(viewModel.user?.isActive == true)
        Verify(updateUserMock, .execute(user: .any))
    }

    func test_destroySession_callsDeleteUserAndSetsUserToNil() {
        // Arrange
        let user = DummyBuilder.createUser(type: .seller)
        viewModel.user = user
        Given(
            deleteUserMock,
                .execute(
                    user: .value(user),
                    willReturn:
                        Just(())
                        .setFailureType(to: FirestoreError.self)
                        .eraseToAnyPublisher()
                )
        )

        // Act
        viewModel.destroySession()

        // Assert
        Verify(deleteUserMock, .execute(user: .value(user)))
        XCTAssertNil(viewModel.user)
    }
}
