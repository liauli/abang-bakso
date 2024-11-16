//
//  CreateUser.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 05/11/24.
//

import Combine
import Foundation

protocol CreateUser: AutoMockable {
    func execute(user: User) -> AnyPublisher<Void, FirestoreError>
}

class CreateUserImpl: CreateUser {
    private let userRepository: UserRepository

    init(_ userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    func execute(user: User) -> AnyPublisher<Void, FirestoreError> {
        return userRepository.create(user: user)
    }
}
