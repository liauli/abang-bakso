//
//  UserRepositoryTest.swift
//  AbangBaksoTests
//
//  Created by aulia_nastiti on 04/11/24.
//

import Combine
import Foundation
import XCTest
import SwiftyMocky

@testable import AbangBakso

class UserRepositoryTest: XCTestCase {
    private var sut: UserRepository!

    private var mockService = DatabaseServiceMock()
    private var mockKeychain = KeychainFacadeMock()

    private var cancellables: Set<AnyCancellable> = []

    override func setUp() {
        registerMatcher()
        sut = UserRepositoryImpl(mockService, mockKeychain)
    }

    // MARK: Test for create(user: User)
    func test_create_success() {
        let expectedSeller = DummyBuilder.createUser(type: .seller)
        Given(mockService,
            .create(
                id: .value(expectedSeller.name), .any,
                willReturn: success(())
            )
        )
        Given(
            mockKeychain,
                .set(
                    data: .any(Data.self),
                    forKey: .value(KeychainKeys.user.rawValue),
                    willProduce: { make in
                        make.return(())
                    }
                )
        )

        let expectation = XCTestExpectation(description: "success")

        sut.create(user: expectedSeller).sink { _ in
            expectation.fulfill()
          } receiveValue: { _ in
              Verify(self.mockService, .once, .create(id: .any, .any))
              Verify(self.mockKeychain, .once, .set(data: .any(Data.self), forKey: .value(KeychainKeys.user.rawValue)))
          }.store(in: &cancellables)

          wait(for: [expectation], timeout: 1)
    }

    func test_create_failed_shouldFail() {
        let expectedCustomer = DummyBuilder.createUser(type: .customer)
        let expectedError = DatabaseError.documentExists
        Given(mockService,
            .create(
                id: .any, .any,
                willReturn: failed(.documentExists)
            )
        )

        let expectation = XCTestExpectation(description: "success")

        sut.create(user: expectedCustomer).sink { completion in
            if case .failure(let error) = completion {
                XCTAssertEqual(expectedError, error)
                Verify(self.mockService, .once, .create(id: .any, .any))
                Verify(self.mockKeychain, .never, .set(data: .any(Data.self), forKey: .any))
                expectation.fulfill()
            }
          } receiveValue: { _ in
            // no result
          }.store(in: &cancellables)

          wait(for: [expectation], timeout: 1)
    }

    func test_create_sellerType_saveUser_keychainSetFailed_shouldFail() {
        let expectedSeller = DummyBuilder.createUser(type: .seller)
        let expectedError = DatabaseError.failedToSaveUser

        Given(mockService,
            .create(
                id: .value(expectedSeller.name), .any,
                willReturn: success(())
            )
        )
        Given(
            mockKeychain,
                .set(
                    data: .any(Data.self),
                    forKey: .value(KeychainKeys.user.rawValue),
                    willProduce: { make in
                        make.throw(expectedError)
                    }
                )
        )

        let expectation = XCTestExpectation(description: "success")

        sut.create(user: expectedSeller).sink { completion in
            if case .failure(let error) = completion {
                XCTAssertEqual(expectedError, error)
                Verify(self.mockService, .once, .create(id: .any, .any))
                Verify(self.mockKeychain, .once, .set(data: .any(Data.self), forKey: .any))
                expectation.fulfill()
            }
          } receiveValue: { _ in
            // no result
          }.store(in: &cancellables)

          wait(for: [expectation], timeout: 1)
    }

    func test_startObserveUser_should_return_users() {
        let dummyUser = DummyBuilder.createUser(type: .customer)

        let dummyDocuments = [
            DocumentSnapshotWrapper(type: dummyUser.type, data: dummyUser.dictionary, isExists: false)
        ]
        Given(mockService,
              .startObserving(query: .any, disconnectValue: .any, willReturn: alwaysSuccess(dummyDocuments))
        )

        let expectation = XCTestExpectation(description: "success")

        sut.startObserveUser().sink { _ in
            expectation.fulfill()
          } receiveValue: { response in
              Verify(self.mockService, .once, .startObserving(query: .any, disconnectValue: .any))
              guard let user = response.first else { return }
              XCTAssertEqual(user.id, dummyUser.id)
              XCTAssertEqual(user.type, dummyUser.type)
              XCTAssertEqual(user.name, dummyUser.name)
              XCTAssertEqual(user.location.latitude, dummyUser.location.latitude)
              XCTAssertEqual(user.location.longitude, dummyUser.location.longitude)
              XCTAssertTrue(user.lastActive.isAlmostEqual(to: dummyUser.lastActive)) // Custom Date comparison
              XCTAssertEqual(user.isActive, dummyUser.isActive)
          }.store(in: &cancellables)
        wait(for: [expectation], timeout: 1)
    }

    func test_stopObserving() {
        sut.stopObserving()
        Verify(mockService, .once, .stopObserving())
    }

    func test_deleteUser_success() {
        // Arrange
        let user = DummyBuilder.createUser(type: .customer)

        // Mock service.delete to return success

        Given(
            mockService,
                .delete(
                    id: .value(user.id),
                    willReturn: Just(()).setFailureType(
                        to: DatabaseError.self).eraseToAnyPublisher()
                )
        )

        // Mock keychain remove operation to succeed
        Given(mockKeychain, .remove(forKey: .value(KeychainKeys.user.rawValue), willProduce: { make in
            make.return(())
        }))

        // Act
        let expectation = XCTestExpectation(description: "Delete user should succeed")
        sut.delete(user: user)
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Expected success, but got failure")
                }
                expectation.fulfill()
            }, receiveValue: { })
            .store(in: &cancellables)

        // Assert
        wait(for: [expectation], timeout: 1.0)
        Verify(mockService, .delete(id: .value(user.id)))
        Verify(mockKeychain, .remove(forKey: .value(KeychainKeys.user.rawValue)))
    }

    func test_deleteUser_failureInServiceDelete() {
        // Arrange
        let user = DummyBuilder.createUser(type: .customer)
        let expectedError = DatabaseError.snapshotError(NSError(domain: "", code: -1, userInfo: nil))

        // Mock service.delete to return failure
        Given(mockService, .delete(id: .value(user.id), willReturn: Fail(error: expectedError).eraseToAnyPublisher()))

        // Act
        let expectation = XCTestExpectation(description: "Delete user should fail on service error")
        sut.delete(user: user)
            .sink(receiveCompletion: { completion in
                if case let .failure(error) = completion {
                    XCTAssertEqual(error, expectedError)
                    expectation.fulfill()
                }
            }, receiveValue: { })
            .store(in: &cancellables)

        // Assert
        wait(for: [expectation], timeout: 1.0)
        Verify(mockService, .once, .delete(id: .value(user.id)))
        Verify(mockKeychain, .never, .remove(forKey: .any))
    }

    func test_deleteUser_failureInRemoveUser() {
        // Arrange
        let user = DummyBuilder.createUser(type: .customer)
        let expectedError = DatabaseError.failedToDeleteUser(NSError(domain: "", code: -1, userInfo: nil))

        // Mock service.delete to return success
        Given(
            mockService, .delete(
                id: .any,
                willReturn: Just(()).setFailureType(
                    to: DatabaseError.self).eraseToAnyPublisher()
            )
        )
        // Mock keychain remove operation to fail
        Given(mockKeychain, .remove(forKey: .value(KeychainKeys.user.rawValue), willThrow: expectedError))

        // Act
        let expectation = XCTestExpectation(description: "Delete user should fail on keychain error")
        sut.delete(user: user)
            .sink(receiveCompletion: { completion in
                var isErrorSame = false
                if case let .failure(error) = completion {
                    if case .failedToDeleteUser = error {
                        isErrorSame = true
                    }
                    XCTAssertTrue(isErrorSame)
                    expectation.fulfill()
                }
            }, receiveValue: { })
            .store(in: &cancellables)

        // Assert
        wait(for: [expectation], timeout: 1.0)
        Verify(mockService, .once, .delete(id: .value(user.id)))
        Verify(mockKeychain, .once, .remove(forKey: .value(KeychainKeys.user.rawValue)))
    }
}
