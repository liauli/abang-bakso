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

// swiftlint:disable file_length
// swiftlint:disable type_body_length
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
    
    func test_create_shouldFailWhenSelfIsNil() {
        // Arrange
        var repository: UserRepositoryImpl? = UserRepositoryImpl(mockService, mockKeychain)
        weak var weakRepository = repository

        let user = DummyBuilder.createUser(type: .seller)
        let expectation = XCTestExpectation(description: "Create user should fail due to self being nil")

        // Mock service response
        Given(
            mockService, .create(
                id: .any, .any, willReturn: success(())
            )
        )

        // Act
        let publisher = repository?.create(user: user)

        // Release the strong reference to simulate `self` being nil
        repository = nil

        publisher?
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTAssertEqual(error, DatabaseError.failedToSaveUser, "Expected failedToSaveUser error")
                    expectation.fulfill()
                case .finished:
                    XCTFail("Expected failure, but got success")
                }
            }, receiveValue: {
                XCTFail("Expected failure, but got value")
            })
            .store(in: &cancellables)

        // Assert
        wait(for: [expectation], timeout: 1.0)
        XCTAssertNil(weakRepository, "Repository should have been deallocated")
        Verify(mockService, .create(id: .value(user.name), .any))
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
    
    func test_startObserveUser_document_type_nil() {
        // Arrange
        let userWithType = DummyBuilder.createUser(type: .seller)
        let userWithoutTypeData: [String: Any] = [
            "name": "John Doe",
            "location": ["latitude": 0.0, "longitude": 0.0],
            "lastActive": 1732454307.010953,
            "isActive": true
        ]

        // Mock documents: one with a `type`, one without
        let documents: [DocumentSnapshotWrapper] = [
            DocumentSnapshotWrapper(type: .seller, data: userWithType.dictionary, isExists: true),
            DocumentSnapshotWrapper(type: nil, data: userWithoutTypeData, isExists: true)
        ]
        Given(mockService, .startObserving(query: .any, disconnectValue: .any, willReturn: alwaysSuccess(documents)))

        let expectation = XCTestExpectation(
            description: "Should map documents to users, applying default type when type is nil"
        )

        // Act
        sut.startObserveUser()
            .sink { users in
                // Assert
                XCTAssertEqual(users.count, 2, "Expected 2 users")
                XCTAssertEqual(users[0].type, .seller, "First user should retain its original type")
                XCTAssertEqual(users[1].type, .customer, "Second user should default to type .customer")
                expectation.fulfill()
            }
            .store(in: &cancellables)

        // Assert
        wait(for: [expectation], timeout: 1.0)
        Verify(mockService, .startObserving(query: .any, disconnectValue: .any))
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
    
    func test_getLocal_userExists_success() {
        // Arrange
        let user = DummyBuilder.createUser(type: .seller)
        let userData: Data
        do {
            userData = try JSONEncoder().encode(user)
        } catch {
            XCTFail("Failed to encode user: \(error)")
            return
        }
        
        Given(mockKeychain, .get(forKey: .value(KeychainKeys.user.rawValue), willReturn: userData))

        let expectation = XCTestExpectation(description: "Should return the user from the keychain")

        // Act
        sut.getLocal()
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Expected success, but got failure")
                }
            }, receiveValue: { result in
                XCTAssertEqual(result, user, "The returned user should match the stored user")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        // Assert
        wait(for: [expectation], timeout: 1.0)
        Verify(mockKeychain, .get(forKey: .value(KeychainKeys.user.rawValue)))
    }

    func test_getLocal_noUser_success() {
        // Arrange
        Given(mockKeychain, .get(forKey: .value(KeychainKeys.user.rawValue), willReturn: nil))

        let expectation = XCTestExpectation(description: "Should return nil if no user exists in the keychain")

        // Act
        sut.getLocal()
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Expected success, but got failure")
                }
            }, receiveValue: { result in
                XCTAssertNil(result, "The result should be nil if no user is stored")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        // Assert
        wait(for: [expectation], timeout: 1.0)
        Verify(mockKeychain, .get(forKey: .value(KeychainKeys.user.rawValue)))
    }

    func test_getLocal_keychainError_failure() {
        // Arrange
        let keychainError = KeychainFacadeError.failure(status: -1)
        Given(
            mockKeychain, .get(
                forKey: .value(KeychainKeys.user.rawValue), willThrow: DatabaseError.generalError(keychainError)
            )
        )

        let expectation = XCTestExpectation(description: "Should return a general error when keychain throws an error")

        // Act
        sut.getLocal()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    if case .generalError(let underlyingError) = error {
                        XCTAssertEqual(underlyingError.localizedDescription, keychainError.localizedDescription)
                        expectation.fulfill()
                    } else {
                        XCTFail("Expected generalError, but got \(error)")
                    }
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure, but got success")
            })
            .store(in: &cancellables)

        // Assert
        wait(for: [expectation], timeout: 1.0)
        Verify(mockKeychain, .get(forKey: .value(KeychainKeys.user.rawValue)))
    }

    func test_getLocal_decodingError_failure() {
        // Arrange
        let invalidData = Data()
        Given(mockKeychain, .get(forKey: .value(KeychainKeys.user.rawValue), willReturn: invalidData))

        let expectation = XCTestExpectation(description: "Should return a general error when decoding fails")

        // Act
        sut.getLocal()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    if case .generalError(let underlyingError) = error {
                        XCTAssertTrue(underlyingError is DecodingError)
                        expectation.fulfill()
                    } else {
                        XCTFail("Expected generalError, but got \(error)")
                    }
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure, but got success")
            })
            .store(in: &cancellables)

        // Assert
        wait(for: [expectation], timeout: 1.0)
        Verify(mockKeychain, .get(forKey: .value(KeychainKeys.user.rawValue)))
    }
    
    func test_getLocal_nonDatabaseError_failure() {
        // Arrange
        let unexpectedError = NSError(domain: "TestErrorDomain", code: 42, userInfo: nil)
        Given(mockKeychain, .get(forKey: .value(KeychainKeys.user.rawValue), willThrow: unexpectedError))

        let expectation = XCTestExpectation(description: "Should wrap a non-DatabaseError in generalError")

        // Act
        sut.getLocal()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    if case .generalError(let underlyingError) = error {
                        XCTAssertEqual(underlyingError as NSError, unexpectedError)
                        expectation.fulfill()
                    } else {
                        XCTFail("Expected generalError, but got \(error)")
                    }
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure, but got success")
            })
            .store(in: &cancellables)

        // Assert
        wait(for: [expectation], timeout: 1.0)
        Verify(mockKeychain, .get(forKey: .value(KeychainKeys.user.rawValue)))
    }
}

// swiftlint:enable type_body_length
