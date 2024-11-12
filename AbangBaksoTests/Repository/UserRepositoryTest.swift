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
import FirebaseFirestore

@testable import AbangBakso

class UserRepositoryTest: XCTestCase {
    private var sut: UserRepository!
    
    private var mockService = FirestoreServiceMock()
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
                id: .value(expectedSeller.name),
                .value(expectedSeller.dictionary),
                willReturn: success(())
            )
        )
        Given(mockKeychain, .set(data: .any(Data.self), forKey: .value(KeychainKeys.user.rawValue), willProduce: { make in
            make.return(())
        }))
        
        let expectation = XCTestExpectation(description: "success")
        
        sut.create(user: expectedSeller).sink { _ in
            expectation.fulfill()
          } receiveValue: { response in
              Verify(self.mockService, .once, .create(id: .any, .any))
              Verify(self.mockKeychain, .once, .set(data: .any(Data.self), forKey: .value(KeychainKeys.user.rawValue)))
          }.store(in: &cancellables)

          wait(for: [expectation], timeout: 1)
    }
    
    func test_create_failed_shouldFail() {
        let expectedCustomer = DummyBuilder.createUser(type: .customer)
        let expectedError = FirestoreError.documentExists
        Given(mockService,
            .create(
                id: .value(expectedCustomer.name),
                .value(expectedCustomer.dictionary),
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
            //no result
          }.store(in: &cancellables)

          wait(for: [expectation], timeout: 1)
    }
    
    func test_create_sellerType_saveUser_keychainSetFailed_shouldFail() {
        let expectedSeller = DummyBuilder.createUser(type: .seller)
        let expectedError = FirestoreError.failedToSaveUser
        
        Given(mockService,
            .create(
                id: .value(expectedSeller.name),
                .value(expectedSeller.dictionary),
                willReturn: success(())
            )
        )
        Given(mockKeychain, .set(data: .any(Data.self), forKey: .value(KeychainKeys.user.rawValue), willProduce: { make in
            make.throw(expectedError)
        }))
        
        let expectation = XCTestExpectation(description: "success")
        
        sut.create(user: expectedSeller).sink { completion in
            if case .failure(let error) = completion {
                XCTAssertEqual(expectedError, error)
                Verify(self.mockService, .once, .create(id: .any, .any))
                Verify(self.mockKeychain, .once, .set(data: .any(Data.self), forKey: .any))
                expectation.fulfill()
            }
          } receiveValue: { _ in
            //no result
          }.store(in: &cancellables)

          wait(for: [expectation], timeout: 1)
    }
    
    
    func test_startObserveUser_should_return_users() {
        let dummyUser = DummyBuilder.createUser(type: .customer)
        
        let dummyDocuments = [
            DocumentSnapshotWrapper(data: dummyUser.dictionary, isExists: false)
        ]
        Given(mockService,
            .startObserving(willReturn: alwaysSuccess(dummyDocuments))
        )
        
        let expectation = XCTestExpectation(description: "success")
        
        sut.startObserveUser().sink { _ in
            expectation.fulfill()
          } receiveValue: { response in
              Verify(self.mockService, .once, .startObserving())
              XCTAssertEqual(response.first, dummyUser)
          }.store(in: &cancellables)
        wait(for: [expectation], timeout: 1)
    }
    
    func test_stopObserving() {
        sut.stopObserving()
        Verify(mockService, .once, .stopObserving())
    }
}
