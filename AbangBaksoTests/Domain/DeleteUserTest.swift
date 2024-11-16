//
//  DomainUserTest.swift
//  AbangBaksoTests
//
//  Created by aulia_nastiti on 14/11/24.
//

import Foundation
import XCTest
import Combine
import SwiftyMocky
@testable import AbangBakso

class DeleteUserTests: XCTestCase {
    var sut: DeleteUserImpl!
    var userRepositoryMock: UserRepositoryMock!
    var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        userRepositoryMock = UserRepositoryMock()
        sut = DeleteUserImpl(userRepositoryMock)
        cancellables = []
    }

    override func tearDown() {
        sut = nil
        userRepositoryMock = nil
        cancellables = nil
        super.tearDown()
    }

    func testExecute_WhenDeleteUserIsCalled_ShouldInvokeDeleteOnRepository() {
        let mockUser = User(type: .customer, ["name": "John Doe"])

        Given(userRepositoryMock, .delete(user: .value(mockUser), willReturn: success(())))

        var resultError: FirestoreError?
        sut.execute(user: mockUser)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    resultError = error
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)

        Verify(userRepositoryMock, .once, .delete(user: .value(mockUser)))

        XCTAssertNil(resultError)
    }

    func testExecute_WhenDeleteUserFails_ShouldReturnError() {
        let mockUser = User(type: .customer, ["name": "John Doe"])

        let expectedError = FirestoreError.failedToDeleteUser(NSError(domain: "", code: 0))
        Given(userRepositoryMock, .delete(user: .value(mockUser), willReturn: failed(expectedError)))

        let expectation = XCTestExpectation(description: "Should fail")

        sut.execute(user: mockUser)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    var isErrorEqual = false
                    if case .failedToDeleteUser(let _) = error {
                        isErrorEqual = true
                    }
                    XCTAssertTrue(isErrorEqual)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)

        Verify(userRepositoryMock, .once, .delete(user: .value(mockUser)))
        wait(for: [expectation], timeout: 1.0)
    }
}
