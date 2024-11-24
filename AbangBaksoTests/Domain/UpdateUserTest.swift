//
//  UpdateUserTest.swift
//  AbangBaksoTests
//
//  Created by aulia_nastiti on 13/11/24.
//

import Foundation
import XCTest
import Combine
import SwiftyMocky

@testable import AbangBakso

final class UpdateUserImplTests: XCTestCase {
    private var userRepositoryMock: UserRepositoryMock!
    private var updateUser: UpdateUserImpl!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        userRepositoryMock = UserRepositoryMock()
        updateUser = UpdateUserImpl(userRepositoryMock)
        cancellables = []
    }

    override func tearDown() {
        userRepositoryMock = nil
        updateUser = nil
        cancellables = nil
        super.tearDown()
    }

    func test_execute_callsUserRepositoryUpdate() {
        // Arrange
        let user = DummyBuilder.createUser(type: .customer)
        Given(
            userRepositoryMock,
                .update(
                    user: .value(user),
                    willReturn:
                        Just(()).setFailureType(to: FirestoreError.self).eraseToAnyPublisher()
                )
        )

        // Act
        let expectation = XCTestExpectation(description: "Should call userRepository.update and complete successfully")
        updateUser.execute(user: user)
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Expected success, but got failure.")
                }
                expectation.fulfill()
            }, receiveValue: { })
            .store(in: &cancellables)

        // Assert
        Verify(userRepositoryMock, .update(user: .value(user)))
        wait(for: [expectation], timeout: 1.0)
    }

    func test_execute_returnsErrorFromRepository() {
        // Arrange
        let user = DummyBuilder.createUser(type: .customer)
        let expectedError = FirestoreError.snapshotError(NSError(domain: "", code: -1, userInfo: nil))
        Given(
            userRepositoryMock,
                .update(
                    user: .value(user),
                    willReturn: Fail(error: expectedError).eraseToAnyPublisher()
                )
        )

        // Act
        let expectation = XCTestExpectation(description: "Should return failure with FirestoreError")
        updateUser.execute(user: user)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    XCTAssertEqual(error, expectedError)
                    expectation.fulfill()
                }
            }, receiveValue: { })
            .store(in: &cancellables)

        // Assert
        Verify(userRepositoryMock, .update(user: .value(user)))
        wait(for: [expectation], timeout: 1.0)
    }
}
