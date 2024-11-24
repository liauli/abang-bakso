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
    func create(user: User) -> AnyPublisher<Void, DatabaseError>
    func startObserveUser() -> AnyPublisher<[User], Never>
    func stopObserving()
    func update(user: User) -> AnyPublisher<Void, DatabaseError>
    func delete(user: User) -> AnyPublisher<Void, DatabaseError>
    func getLocal() -> AnyPublisher<User?, DatabaseError>
}

class UserRepositoryImpl: UserRepository {
    private let service: DatabaseService
    private let keychain: KeychainFacade

    init(_ service: DatabaseService,
         _ keychain: KeychainFacade
    ) {
        self.service = service
        self.keychain = keychain
    }

    func update(user: User) -> AnyPublisher<Void, DatabaseError> {
        return service.update(id: user.name, user.dictionary)
    }

    func create(user: User) -> AnyPublisher<Void, DatabaseError> {
        service.create(id: user.name, user.dictionary).flatMap { [weak self] _ -> AnyPublisher<Void, DatabaseError> in
            guard let self = self else {
                return Fail(error: DatabaseError.failedToSaveUser).eraseToAnyPublisher()
            }

            return self.saveUser(user: user)
        }
        .eraseToAnyPublisher()
    }

    private func saveUser(user: User) -> AnyPublisher<Void, DatabaseError> {
        do {
            let data = try JSONEncoder().encode(user)
            try keychain.set(data: data, forKey: KeychainKeys.user.rawValue)

            return Just(()).setFailureType(to: DatabaseError.self).eraseToAnyPublisher()
        } catch {
            return Fail(error: DatabaseError.failedToSaveUser).eraseToAnyPublisher()
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

    func delete(user: User) -> AnyPublisher<Void, DatabaseError> {
        return service.delete(id: user.id).flatMap({ [weak self] _ -> AnyPublisher<Void, DatabaseError> in
            do {
                try self?.keychain.remove(forKey: KeychainKeys.user.rawValue)
                return Just(()).setFailureType(to: DatabaseError.self).eraseToAnyPublisher()
            } catch {
                return Fail(error: DatabaseError.failedToDeleteUser(error)).eraseToAnyPublisher()
            }
        }).eraseToAnyPublisher()
            
    }
    
    private func removeUser() -> AnyPublisher<Void, DatabaseError> {
        do {
            try keychain.remove(forKey: KeychainKeys.user.rawValue)

            return Just(()).setFailureType(to: DatabaseError.self).eraseToAnyPublisher()
        } catch {
            return Fail(error: DatabaseError.failedToDeleteUser(error)).eraseToAnyPublisher()
        }
    }
    
    func getLocal() -> AnyPublisher<User?, DatabaseError> {
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
