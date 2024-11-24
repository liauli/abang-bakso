//
//  DeleteUser.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 14/11/24.
//

import Combine
import Foundation

protocol DeleteUser: AutoMockable {
    func execute(user: User) -> AnyPublisher<Void, DatabaseError>
}

class DeleteUserImpl: DeleteUser {
    private let userRepository: UserRepository

    init(_ userRepository: UserRepository) {
        self.userRepository = userRepository
    }

    func execute(user: User) -> AnyPublisher<Void, DatabaseError> {
        return userRepository.delete(user: user)
    }
}
