//
//  ObserveCustomer.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 12/11/24.
//

import Combine
import Foundation

protocol ObserveUser {
    func execute() -> AnyPublisher<[User], Never>
    func stop()
}

class ObserveUserImpl: ObserveUser {
    private let userRepository: UserRepository
    
    init(_ userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func execute() -> AnyPublisher<[User], Never> {
        return userRepository.startObserveUser()
    }
    
    func stop() {
        userRepository.stopObserving()
    }
}
