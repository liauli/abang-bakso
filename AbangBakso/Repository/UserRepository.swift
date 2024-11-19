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
    func update(user: User) -> AnyPublisher<Void, FirestoreError>
    func delete(user: User) -> AnyPublisher<Void, FirestoreError>
    func getLocal() -> AnyPublisher<User?, FirestoreError>
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

    func update(user: User) -> AnyPublisher<Void, FirestoreError> {
        return service.update(id: user.name, user.dictionary)
    }

    func create(user: User) -> AnyPublisher<Void, FirestoreError> {
        service.create(id: user.name, user.dictionary).flatMap { [weak self] _ -> AnyPublisher<Void, FirestoreError> in
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

    func startObserveUser() -> AnyPublisher<[User], Never> {
        var query = ("isActive", true)
        return service.startObserving(query: query, disconnectValue: [:])
            .map { documents -> [User] in
                return documents.map { document in
                    User(type: document.type ?? .customer, document.data)
                }
            }
            .eraseToAnyPublisher()
    }

    func delete(user: User) -> AnyPublisher<Void, FirestoreError> {
        return service.delete(id: user.id).flatMap({ [weak self] _ -> AnyPublisher<Void, FirestoreError> in
            do {
                try self?.keychain.remove(forKey: KeychainKeys.user.rawValue)
                return Just(()).setFailureType(to: FirestoreError.self).eraseToAnyPublisher()
            } catch {
                return Fail(error: FirestoreError.failedToDeleteUser(error)).eraseToAnyPublisher()
            }
        }).eraseToAnyPublisher()
            
    }
    
    func getLocal() -> AnyPublisher<User?, FirestoreError> {
        return Future { [weak self] promise in
            do {
                if let userData = try self?.keychain.get(forKey: KeychainKeys.user.rawValue) {
                    
                    let user = try JSONDecoder().decode(User.self, from: userData)
                    promise(.success(user))
                } else {
                    promise(.success(nil))
                }
            } catch {
                promise(.failure(.generalError(error)))
            }
        }.eraseToAnyPublisher()
    }
}
