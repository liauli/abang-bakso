//
//  MapViewModel.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 12/11/24.
//

import Foundation
import Combine

class MapViewModel: ObservableObject {
    var user: User? = nil
    
    // MARK: temp
    private let sellerRepository: UserRepository
    
    private let observeCustomer: ObserveUser
    
    var cancellabels = Set<AnyCancellable>()
    
    @Published private(set) var customers: [User] = []
    
    init(
        _ observeCustomer: ObserveUser,
        _ sellerRepository: UserRepository
    ) {
        self.observeCustomer = observeCustomer
        self.sellerRepository = sellerRepository
    }
    
    func startObservingCustomers() {
        observeCustomer.execute().sink { comp in
            // comp
        } receiveValue: { users in
            self.customers = users
        }.store(in: &cancellabels)
    }
    
    func stopObservingCustomers(){
        observeCustomer.stop()
    }
    
    func setSellerOffline() {
        user?.isActive = false
        if let user = user {
            sellerRepository.update(user: user).sink { comp in
                // comp
            } receiveValue: { _ in
                print("completed")
            }.store(in: &cancellabels)
        }
    }
}
