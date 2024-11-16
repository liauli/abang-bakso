//
//  UpdateUser.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 13/11/24.
//

import Combine
import Foundation

protocol UpdateUser: AutoMockable {
    func execute(user: User) -> AnyPublisher<Void, FirestoreError>
}

class UpdateUserImpl: UpdateUser {
    private let userRepository: UserRepository

    init(_ userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    func execute(user: User) -> AnyPublisher<Void, FirestoreError> {
        return userRepository.update(user: user)
    }
}
