//
//  ObserveUserTest.swift
//  AbangBaksoTests
//
//  Created by aulia_nastiti on 12/11/24.
//

import Foundation
import XCTest
import Combine
@testable import AbangBakso

class ObserveUserTests: XCTestCase {
    var sut: ObserveUser!
    var userRepositoryMock: UserRepositoryMock!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        userRepositoryMock = UserRepositoryMock()
        sut = ObserveUserImpl(userRepositoryMock)
        cancellables = []
    }

    override func tearDown() {
        sut = nil
        userRepositoryMock = nil
        cancellables = nil
        super.tearDown()
    }

    func testExecute_WhenCalled_ShouldReturnUsers() {
        let expectedUsers = [
            DummyBuilder.createUser(type: .seller, name: "John"),
            DummyBuilder.createUser(type: .seller, name: "Alice"),
        ]
        
        userRepositoryMock.given(.startObserveUser(willReturn: Just(expectedUsers).eraseToAnyPublisher()))
        
        var result: [User] = []
        let expectation = XCTestExpectation(description: "success")
        
        sut.execute()
            .sink(receiveCompletion: { _ in
                expectation.fulfill()
            }, receiveValue: { users in
                result = users
                XCTAssertNotNil(result)
                XCTAssertEqual(result.count, 2)
                XCTAssertEqual(result.first?.name, "John")
                XCTAssertEqual(result.last?.name, "Alice")
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }

    func testExecute_WhenRepositoryReturnsEmpty_ShouldReturnEmptyArray() {
        let expectedUsers: [User] = []
        
        userRepositoryMock.given(.startObserveUser(willReturn: Just(expectedUsers).eraseToAnyPublisher()))
        
        var result: [User] = []
        let expectation = XCTestExpectation(description: "success")
        
        sut.execute()
            .sink(receiveCompletion: { _ in
                expectation.fulfill()
            }, receiveValue: { users in
                result = users
                XCTAssertNotNil(result)
                XCTAssertEqual(result.count, 0)
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1)
    }
}
