//
//  GetCurrentUser.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 14/11/24.
//

import Combine
import Foundation

protocol GetCurrentUser: AutoMockable {
    func execute() -> AnyPublisher<User?, FirestoreError>
}

class GetCurrentUserImpl: GetCurrentUser {
    private let userRepository: UserRepository
    
    init(_ userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func execute() -> AnyPublisher<User?, FirestoreError> {
        return userRepository.getLocal()
    }
}
