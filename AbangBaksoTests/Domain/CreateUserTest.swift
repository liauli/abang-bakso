//
//  CreateUserTest.swift
//  AbangBaksoTests
//
//  Created by aulia_nastiti on 05/11/24.
//

import XCTest
import Combine
import SwiftyMocky
@testable import AbangBakso

class CreateUserTests: XCTestCase {
    private var userRepositoryMock: UserRepositoryMock!
    private var createUser: CreateUser!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        registerMatcher()

        userRepositoryMock = UserRepositoryMock()
        createUser = CreateUserImpl(userRepositoryMock)
        cancellables = []
    }

    override func tearDown() {
        cancellables = nil
        super.tearDown()
    }

    func testExecuteCallsCreateOnUserRepositorySucceeds() {
        // Arrange
        let user = DummyBuilder.createUser(type: .seller)

        Given(userRepositoryMock, .create(user: .value(user), willReturn: success(()).eraseToAnyPublisher()))

        // Act & Assert
        let expectation = self.expectation(description: "User creation succeeds")

        createUser.execute(user: user)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure:
                    XCTFail("Expected success, but got failure.")
                }
            }, receiveValue: {
                // no action
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 1.0, handler: nil)

        // Verify that userRepository.create was called once
        Verify(userRepositoryMock, .create(user: .value(user)))
    }

    func testExecute_callsCreateOnUserRepository_andFails() {
        // Arrange
        let user = DummyBuilder.createUser(type: .seller)
        let expectedError = FirestoreError.unknownType
        Given(userRepositoryMock, .create(user: .value(user), willReturn: Fail(error: expectedError).eraseToAnyPublisher()))

        // Act & Assert
        let expectation = self.expectation(description: "User creation fails")

        createUser.execute(user: user)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    XCTFail("Expected failure, but got success.")
                case .failure(let error):
                    XCTAssertEqual(error, expectedError)
                    expectation.fulfill()
                }
            }, receiveValue: {
                // no action
            })
            .store(in: &cancellables)

        waitForExpectations(timeout: 1.0, handler: nil)

        // Verify that userRepository.create was called once
        Verify(userRepositoryMock, .create(user: .value(user)))
    }
}
