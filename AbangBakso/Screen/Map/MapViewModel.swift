//
//  MapViewModel.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 12/11/24.
//

import Foundation
import Combine
import CoreLocation
import FirebaseFirestore

class MapViewModel: ObservableObject {
    @Published var user: User? = nil

    
    private let observeCustomer: ObserveUser
    private let updateSeller: UpdateUser
    private let observeLocation: GetLocationUpdates
    
    var cancellabels = Set<AnyCancellable>()
    
    @Published private(set) var customers: [User] = []
    
    deinit {
        stopObserving()
        setOnline(false)
    }
    
    init(
        _ observeCustomer: ObserveUser,
        _ updateSeller: UpdateUser,
        _ observeLocation: GetLocationUpdates
    ) {
        self.observeCustomer = observeCustomer
        self.observeLocation = observeLocation
        self.updateSeller = updateSeller
    }
    
    func startObservingCustomers() {
        observeCustomer.execute().sink { comp in
            // comp
        } receiveValue: { users in
            self.customers = users
        }.store(in: &cancellabels)
    }
    
    func startObservingLocation() {
        observeLocation.execute().sink { comp in
            // comp
        } receiveValue: { [unowned self] loc in
            let newLoc = CLLocation(latitude: loc.latitude, longitude: loc.longitude)
            let prevLoc = CLLocation(latitude: self.user?.location.latitude ?? 0, longitude: self.user?.location.longitude ?? 0)
            let distance = newLoc.distance(from: prevLoc)
            if distance >= 5 {
                let geo = GeoPoint(latitude: loc.latitude, longitude: loc.longitude)
                self.user?.location = geo
                self.updateUser()
            }
            
        }.store(in: &cancellabels)
    }
    
    func stopObserving(){
        observeCustomer.stop()
        observeLocation.stop()
    }
    
    func updateUser() {
        if let user = user {
            updateSeller.execute(user: user).sink { comp in
                // comp
            } receiveValue: { _ in
                // no vlaue
            }.store(in: &cancellabels)
        }
    }
    
    func setOnline(_ isOnline: Bool) {
        user?.isActive = isOnline
        updateUser()
    }
}
