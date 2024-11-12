//
//  UserRepository.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 01/11/24.
//

import Combine
import Foundation
import FirebaseFirestore

protocol UserRepository: AutoMockable {
    func create(user: User) -> AnyPublisher<Void, FirestoreError>
    func startObserveUser() -> AnyPublisher<[User], Never>
    func stopObserving()
}

class UserRepositoryImpl: UserRepository {
    private let service: FirestoreService
    private let keychain: KeychainFacade
    
    init(_ service: FirestoreService,
         _ keychain: KeychainFacade
    ) {
        self.service = service
        self.keychain = keychain
    }
    
    func create(user: User) -> AnyPublisher<Void, FirestoreError> {
        service.create(id: user.name, user.dictionary).flatMap { [weak self] void -> AnyPublisher<Void, FirestoreError> in
            guard let self = self else {
                return Fail(error: FirestoreError.failedToSaveUser).eraseToAnyPublisher()
            }
            
            return self.saveUser(user: user)
        }
        .eraseToAnyPublisher()
    }
    
    private func saveUser(user: User) -> AnyPublisher<Void, FirestoreError> {
        do {
            let data = try JSONEncoder().encode(user)
            try keychain.set(data: data, forKey: KeychainKeys.user.rawValue)
            
            return Just(()).setFailureType(to: FirestoreError.self).eraseToAnyPublisher()
        } catch {
            return Fail(error: FirestoreError.failedToSaveUser).eraseToAnyPublisher()
        }
    }
    
    func stopObserving() {
        return service.stopObserving()
    }
    
    func startObserveUser() -> AnyPublisher<[User], Never>{
        return service.startObserving()
            .map { documents -> [User] in
                return documents.map { document in
                    User(type: .customer, document.data)
                }
            }
            .eraseToAnyPublisher()
    }
}
