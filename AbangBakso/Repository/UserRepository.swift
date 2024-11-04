//
//  UserRepository.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 01/11/24.
//

import Combine
import Foundation
import FirebaseFirestore

protocol UserRepository {
    func create(user: User) -> AnyPublisher<Void, FirestoreError>
    func getProfile() -> AnyPublisher<User, FirestoreError>
    func endSession() -> AnyPublisher<Void, Never>
}

class UserRepositoryImpl: UserRepository {
    private let sellerService: FirestoreService
    private let customerService: FirestoreService
    private let keychain: KeychainFacade
    
    init(_ sellerService: FirestoreService,
         _ customerService: FirestoreService,
         _ keychain: KeychainFacade
    ) {
        self.sellerService = sellerService
        self.customerService = customerService
        self.keychain = keychain
    }
    
    func create(user: User) -> AnyPublisher<Void, FirestoreError> {
        doCreate(user: user).flatMap { [weak self] void -> AnyPublisher<Void, FirestoreError> in
            guard let self = self else {
                return Fail(error: FirestoreError.failedToSaveUser).eraseToAnyPublisher()
            }
            
            return self.saveUser(user: user)
        }
        .eraseToAnyPublisher()
    }
    
    private func doCreate(user: User) -> AnyPublisher<Void, FirestoreError> {
        if user.type == .seller {
            return sellerService.create(id: user.name, user.dictionary)
        } else if user.type == .costumer {
            return customerService.create(id: user.name, user.dictionary)
        } else {
            return Fail(error: FirestoreError.unknownType).eraseToAnyPublisher()
        }
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
    
    func getProfile()-> AnyPublisher<User, FirestoreError> {
        do {
            if let userData = try keychain.get(forKey: KeychainKeys.user.rawValue) {
                
                let user = try JSONDecoder().decode(User.self, from: userData)
                return Just(user).setFailureType(to: FirestoreError.self).eraseToAnyPublisher()
            } else {
                return Fail(error: FirestoreError.failedToGetUser).eraseToAnyPublisher()
            }

        } catch {
            return Fail(error: FirestoreError.failedToGetUser).eraseToAnyPublisher()
        }
    }
    
    // TODO: End session: lastactive false or remove everything?
    func endSession() -> AnyPublisher<Void, Never> {
        do {
            
            if let userData = try keychain.get(forKey: KeychainKeys.user.rawValue) {
                
                try keychain.remove(forKey: KeychainKeys.user.rawValue)
                
                var user = try JSONDecoder().decode(User.self, from: userData)
                user.isActive = false
                user.lastActive = Timestamp(date: Date())
                switch user.type {
                case .seller:
                    return sellerService.update(id: user.name, user.dictionary).replaceError(with: ()).eraseToAnyPublisher()
                case .costumer:
                    return customerService.update(id: user.name, user.dictionary).replaceError(with: ()).eraseToAnyPublisher()
                }
            }
            
        } catch {
            return Just(()).eraseToAnyPublisher()
        }
        
        return Just(()).eraseToAnyPublisher()
    }
}
