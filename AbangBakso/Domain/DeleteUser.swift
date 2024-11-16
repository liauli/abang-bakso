//
//  DeleteUser.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 14/11/24.
//

import Combine
import Foundation

protocol DeleteUser: AutoMockable {
    func execute(user: User) -> AnyPublisher<Void, FirestoreError>
}

class DeleteUserImpl: DeleteUser {
    private let userRepository: UserRepository

    init(_ userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    func execute(user: User) -> AnyPublisher<Void, FirestoreError> {
        return userRepository.delete(user: user)
    }
}
