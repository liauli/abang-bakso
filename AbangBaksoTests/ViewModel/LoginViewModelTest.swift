//
//  LoginViewModelTest.swift
//  AbangBaksoTests
//
//  Created by aulia_nastiti on 11/11/24.
//
import XCTest
import Combine
import CoreLocation
import FirebaseFirestore
import SwiftyMocky
@testable import AbangBakso

final class LoginViewModelTests: XCTestCase {
    private var viewModel: LoginViewModel!
    private var createCustomerUserMock: CreateUserMock!
    private var createSellerUserMock: CreateUserMock!
    private var getLocationUpdatesMock: GetLocationUpdatesMock!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        createCustomerUserMock = CreateUserMock()
        createSellerUserMock = CreateUserMock()
        getLocationUpdatesMock = GetLocationUpdatesMock()

        viewModel = LoginViewModel(createCustomerUserMock, createSellerUserMock, getLocationUpdatesMock)
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        createCustomerUserMock = nil
        createSellerUserMock = nil
        getLocationUpdatesMock = nil
        cancellables = nil
        super.tearDown()
    }

    // MARK: - Test Initial State

    func test_initialState() {
        XCTAssertEqual(viewModel.name, "")
        XCTAssertNil(viewModel.role)
        XCTAssertFalse(viewModel.isTermChecked)
        XCTAssertFalse(viewModel.isButtonEnabled)
        XCTAssertFalse(viewModel.isLoggedIn)
        XCTAssertNil(viewModel.location)
    }

    // MARK: - Test Button Enabled State
    func test_buttonEnabled_whenNameRoleAndTermsSet() {
        viewModel.name = "Test User"
        viewModel.role = .customer
        viewModel.isTermChecked = true

        XCTAssertTrue(viewModel.isButtonEnabled)

        viewModel.isTermChecked = false
        XCTAssertFalse(viewModel.isButtonEnabled)

        viewModel.isTermChecked = true
        XCTAssertTrue(viewModel.isButtonEnabled)

        viewModel.role = nil
        XCTAssertFalse(viewModel.isButtonEnabled)

        viewModel.role = .seller
        XCTAssertTrue(viewModel.isButtonEnabled)

        viewModel.name = ""
        XCTAssertFalse(viewModel.isButtonEnabled)

    }

    func test_buttonDisabled_whenNameIsEmpty() {
        viewModel.name = ""
        viewModel.role = .customer
        viewModel.isTermChecked = true

        XCTAssertFalse(viewModel.isButtonEnabled, "Button should be disabled when name is empty")
    }

    func test_buttonDisabled_whenRoleIsNil() {
        viewModel.name = "Test User"
        viewModel.role = nil
        viewModel.isTermChecked = true

        XCTAssertFalse(viewModel.isButtonEnabled, "Button should be disabled when role is nil")
    }

    func test_buttonDisabled_whenTermsNotChecked() {
        viewModel.name = "Test User"
        viewModel.role = .customer
        viewModel.isTermChecked = false

        XCTAssertFalse(viewModel.isButtonEnabled, "Button should be disabled when terms are not checked")
    }

    // MARK: - Test Location Updates

    func test_locationUpdates() {
        let mockLocation = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)

        getLocationUpdatesMock.given(.execute(willReturn: Just(mockLocation).eraseToAnyPublisher()))

        viewModel.getCurrentLocation()

        XCTAssertEqual(viewModel.location?.latitude, mockLocation.latitude)
        XCTAssertEqual(viewModel.location?.longitude, mockLocation.longitude)

        getLocationUpdatesMock.verify(.execute(), count: .once)
    }

    // MARK: - Test doCreateUser

    func test_doCreateUser_asCustomer() {
        viewModel.name = "Customer"
        viewModel.role = .customer
        viewModel.isTermChecked = true

        let expectedUser = DummyBuilder.createUser(type: .customer)

        Given(
            createCustomerUserMock,
                .execute(
                    user: .matching { $0.name == expectedUser.name },
                    willReturn:
                        failed(FirestoreError.documentExists).eraseToAnyPublisher()
                )
        )

        viewModel.doCreateUser()

        createCustomerUserMock.verify(.execute(user: .matching { $0.name == expectedUser.name }), count: .once)
        createSellerUserMock.verify(.execute(user: .any), count: .never)
    }

    func test_doCreateUser_asSeller() {
        // Set up the state for creating a seller user
        viewModel.name = "Seller"
        viewModel.role = .seller
        viewModel.isTermChecked = true

        let expectedUser = User(
            type: .seller,
            name: "Seller",
            location: GeoPoint(latitude: 0, longitude: 0),
            lastActive: Timestamp(),
            isActive: true)

        createSellerUserMock.given(
            .execute(
                user: .matching { $0.name == expectedUser.name },
                willReturn:
                    Just(())
                    .setFailureType(to: FirestoreError.self)
                    .eraseToAnyPublisher()
            )
        )

        viewModel.doCreateUser()

        // Verify that createSellerUser.execute was called with the expected user
        createSellerUserMock.verify(.execute(user: .matching { $0.name == expectedUser.name }), count: .once)
        createCustomerUserMock.verify(.execute(user: .any), count: .never)
    }

    func test_doCreateUser_whenTermsNotChecked_doesNotCreateUser() {
        // Set up the state for creating a user without accepting terms
        viewModel.name = "Test User"
        viewModel.role = .customer
        viewModel.isTermChecked = false

        viewModel.doCreateUser()

        // Verify that neither createCustomerUser nor createSellerUser were called
        createCustomerUserMock.verify(.execute(user: .any), count: .never)
        createSellerUserMock.verify(.execute(user: .any), count: .never)
    }
}
