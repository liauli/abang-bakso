//
//  RealtimeDatabaseServiceTest.swift
//  AbangBaksoTests
//
//  Created by aulia_nastiti on 24/11/24.
//
import XCTest
import Combine
import SwiftyMocky
import FirebaseDatabase
@testable import AbangBakso

class RealtimeDatabaseServiceImplTests: XCTestCase {
    var mockReference: DatabaseReferenceCombineMock!
    var mockQuery: DatabaseQueryCombineMock!
    var service: RealtimeDatabaseServiceImpl!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        registerMatcher()
        mockReference = DatabaseReferenceCombineMock()
        mockQuery = DatabaseQueryCombineMock()
        service = RealtimeDatabaseServiceImpl(reference: mockReference, path: "test-path")
        cancellables = []
    }

    override func tearDown() {
        cancellables = nil
        super.tearDown()
    }

    func testCreate_shouldSetValue() {
        // Arrange
        let data = ["key": "value"]
        let id = "user123"
        Given(mockReference, .addChild(.any, willReturn: mockReference))
        Given(mockReference, 
            .setValuePublisher(
                .value(data),
                willReturn: success(())))

        // Act
        let expectation = XCTestExpectation(description: "Create should succeed")
        service.create(id: id, data)
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Expected success but got failure")
                }
            }, receiveValue: {
                expectation.fulfill()
            })
            .store(in: &cancellables)

        // Assert
        wait(for: [expectation], timeout: 1.0)
        Verify(mockReference, .addChild(.value(id)))
        Verify(mockReference, .setValuePublisher(.value(data)))
    }

    func testCreate_shouldHandleFailure() {
        // Arrange
        let data = ["key": "value"]
        let id = "user123"
        let expectedError = DatabaseError.unknownType
        let mockChildReference = DatabaseReferenceCombineMock()
        
        Given(mockReference, .addChild(.value(id), willReturn: mockChildReference))
        Given(mockChildReference, .setValuePublisher(.value(data), willReturn: failed(expectedError)))

        // Act
        let expectation = XCTestExpectation(description: "Create should fail")
        service.create(id: id, data)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTAssertEqual(error.localizedDescription, expectedError.localizedDescription)
                    expectation.fulfill()
                case .finished:
                    XCTFail("Expected failure, but got success")
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure, but got value")
            })
            .store(in: &cancellables)

        // Assert
        wait(for: [expectation], timeout: 1.0)
        Verify(mockReference, .addChild(.value(id)))
        Verify(mockChildReference, .setValuePublisher(.value(data)))
    }
    
    func testUpdate_shouldUpdateValues() {
        // Arrange
        let data = ["key": "updatedValue"]
        let id = "user123"
        // GIVEN ADDCHILD
        Given(mockReference, .addChild(.any, willReturn: mockReference))
        Given(mockReference, .updateChildValuesPublisher(.value(data), willReturn: success(())))

        // Act
        let expectation = XCTestExpectation(description: "Update should succeed")
        service.update(id: id, data)
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Expected success but got failure")
                }
            }, receiveValue: {
                expectation.fulfill()
            })
            .store(in: &cancellables)

        // Assert
        wait(for: [expectation], timeout: 1.0)
        Verify(mockReference, .addChild(.value(id)))
        Verify(mockReference, .updateChildValuesPublisher(.value(data)))
    }
    
    func testUpdate_shouldHandleFailure() {
        // Arrange
        let data = ["key": "updatedValue"]
        let id = "user123"
        let expectedError = DatabaseError.unknownType
        let mockChildReference = DatabaseReferenceCombineMock()
        
        Given(mockReference, .addChild(.value(id), willReturn: mockChildReference))
        Given(mockChildReference, .updateChildValuesPublisher(.value(data), willReturn: failed(expectedError)))

        // Act
        let expectation = XCTestExpectation(description: "Update should fail")
        service.update(id: id, data)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTAssertEqual(error.localizedDescription, expectedError.localizedDescription)
                    expectation.fulfill()
                case .finished:
                    XCTFail("Expected failure, but got success")
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure, but got value")
            })
            .store(in: &cancellables)

        // Assert
        wait(for: [expectation], timeout: 1.0)
        Verify(mockReference, .addChild(.value(id)))
        Verify(mockChildReference, .updateChildValuesPublisher(.value(data)))
    }

    func testStartObserving_shouldReturnSnapshots() {
        // Arrange
        let queryData = [["key1": "value1"], ["key2": "value2"]]
        Given(mockReference, .addQueryOrderedByKey(willReturn: mockQuery))
        Given(mockQuery, .observeValuePublisher(willReturn: success(queryData)))
        
        // Act
        let expectation = XCTestExpectation(description: "Start observing should return snapshots")
        service.startObserving()
            .sink(receiveValue: { snapshots in
                XCTAssertEqual(snapshots.count, 2)
                expectation.fulfill()
            })
            .store(in: &cancellables)

        // Assert
        wait(for: [expectation], timeout: 1.0)
        Verify(mockReference, .addQueryOrderedByKey())
        Verify(mockQuery, .observeValuePublisher())
        Verify(mockReference, .addOnDisconnectSetValue(.any, completion: .any))
    }
    
    func testStartObserving_shouldHandleFailure() {
        // Arrange
        let expectedError = DatabaseError.snapshotError(NSError(domain: "", code: 500))
        Given(mockReference, .addQueryOrderedByKey(willReturn: mockQuery))
        Given(mockQuery, .observeValuePublisher(willReturn: failed(expectedError)))

        // Act
        let expectation = XCTestExpectation(description: "Start observing should fail")
        service.startObserving()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTFail("Expected no error, but got \(error)")
                case .finished:
                    expectation.fulfill() // ReplaceError converts errors to completion
                }
            }, receiveValue: { snapshots in
                XCTAssertTrue(snapshots.isEmpty, "Snapshots should be empty on failure")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        // Assert
        wait(for: [expectation], timeout: 1.0)
        Verify(mockReference, .addQueryOrderedByKey())
        Verify(mockQuery, .observeValuePublisher())
    }
    
    func testStartObserving_onDisconnectSuccess() {
        // Arrange
        let disconnectValue = ["key": "value"]
        let mockQuery = DatabaseQueryCombineMock()
        
        Given(mockReference, .addQueryOrderedByKey(willReturn: mockQuery))
        Given(mockQuery, .observeValuePublisher(willReturn: success([])))
        
        // Simulate `addOnDisconnectSetValue` success
        Perform(mockReference, .addOnDisconnectSetValue(.any, completion: .any, perform: { _, completion in
            completion(nil, nil)
        }))

        // Act
        let expectation = XCTestExpectation(description: "Start observing should succeed")
        service.startObserving(disconnectValue: disconnectValue)
            .sink(receiveValue: { snapshots in
                XCTAssertTrue(snapshots.isEmpty, "Snapshots should be empty on success")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        // Assert
        wait(for: [expectation], timeout: 1.0)
        Verify(mockReference, .addOnDisconnectSetValue(.any, completion: .any))
        Verify(mockReference, .addQueryOrderedByKey())
        Verify(mockQuery, .observeValuePublisher())
    }
    
    func testStartObserving_onDisconnectFailure() {
        // Arrange
        let disconnectValue = ["key": "value"]
        let expectedError = NSError(
            domain: "TestError", code: 123, userInfo: [NSLocalizedDescriptionKey: "Simulated error"]
        )
        let mockQuery = DatabaseQueryCombineMock()
        
        Given(mockReference, .addQueryOrderedByKey(willReturn: mockQuery))
        Given(mockQuery, .observeValuePublisher(willReturn: success([])))
        
        // Simulate `addOnDisconnectSetValue` failure
        Perform(mockReference, .addOnDisconnectSetValue(.any, completion: .any, perform: { _, completion in
            completion(expectedError, nil)
        }))

        // Act
        let expectation = XCTestExpectation(description: "Start observing should log error")
        service.startObserving(disconnectValue: disconnectValue)
            .sink(receiveValue: { snapshots in
                XCTAssertTrue(snapshots.isEmpty, "Snapshots should still be empty despite onDisconnect failure")
                expectation.fulfill()
            })
            .store(in: &cancellables)

        // Assert
        wait(for: [expectation], timeout: 1.0)
        Verify(mockReference, .addOnDisconnectSetValue(.any, completion: .any))
        Verify(mockReference, .addQueryOrderedByKey())
        Verify(mockQuery, .observeValuePublisher())
    }
    
    func testStopObserving_shouldRemoveObserver() {
        // Act
        service.stopObserving()

        // Assert
        Verify(mockReference, .removeObservers())
    }

    func testDelete_shouldRemoveValues() {
        // Arrange
        let id = "user123"
        
        Given(mockReference, .addChild(.any, willReturn: mockReference))
        Given(mockReference,
            .removeValuePublisher(
                willReturn: success(())))

        // Act
        let expectation = XCTestExpectation(description: "Delete should succeed")
        service.delete(id: id)
            .sink(receiveCompletion: { completion in
                if case .failure = completion {
                    XCTFail("Expected success but got failure")
                }
            }, receiveValue: {
                expectation.fulfill()
            })
            .store(in: &cancellables)

        // Assert
        wait(for: [expectation], timeout: 1.0)
            Verify(mockReference, .addChild(.value(id)))
        Verify(mockReference, .removeValuePublisher())
    }
    
    func testDelete_shouldHandleFailure() {
        // Arrange
        let id = "user123"
        let expectedError = DatabaseError.documentExists
        let mockChildReference = DatabaseReferenceCombineMock()
        
        Given(mockReference, .addChild(.value(id), willReturn: mockChildReference))
        Given(mockChildReference, .removeValuePublisher(willReturn: failed(expectedError)))

        // Act
        let expectation = XCTestExpectation(description: "Delete should fail")
        service.delete(id: id)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTAssertEqual(error.localizedDescription, expectedError.localizedDescription)
                    expectation.fulfill()
                case .finished:
                    XCTFail("Expected failure, but got success")
                }
            }, receiveValue: { _ in
                XCTFail("Expected failure, but got value")
            })
            .store(in: &cancellables)

        // Assert
        wait(for: [expectation], timeout: 1.0)
        Verify(mockReference, .addChild(.value(id)))
        Verify(mockChildReference, .removeValuePublisher())
    }
}
