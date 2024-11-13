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

    
    private let observeUser: ObserveUser
    private let updateUser: UpdateUser
    private let observeLocation: GetLocationUpdates?
    
    var cancellabels = Set<AnyCancellable>()
    
    @Published private(set) var customers: [User] = []
    
    deinit {
        stopObserving()
        setOnline(false)
    }
    
    init(
        _ observeUser: ObserveUser,
        _ updateUser: UpdateUser,
        _ observeLocation: GetLocationUpdates? = nil
    ) {
        self.observeUser = observeUser
        self.observeLocation = observeLocation
        self.updateUser = updateUser
    }
    
    func startObservingCustomers() {
        observeUser.execute().sink { comp in
            // comp
        } receiveValue: { users in
            self.customers = users
        }.store(in: &cancellabels)
    }
    
    func startObservingLocation() {
        if user?.type == .customer {
            return
        }
        observeLocation?.execute().sink { comp in
            // comp
        } receiveValue: { [unowned self] loc in
            let newLoc = CLLocation(latitude: loc.latitude, longitude: loc.longitude)
            let prevLoc = CLLocation(latitude: self.user?.location.latitude ?? 0, longitude: self.user?.location.longitude ?? 0)
            let distance = newLoc.distance(from: prevLoc)
            if distance >= 5 {
                let geo = GeoPoint(latitude: loc.latitude, longitude: loc.longitude)
                self.user?.location = geo
                self.updateUserData()
            }
            
        }.store(in: &cancellabels)
    }
    
    func stopObserving(){
        observeUser.stop()
        observeLocation?.stop()
    }
    
    func updateUserData() {
        if let user = user {
            updateUser.execute(user: user).sink { comp in
                // comp
            } receiveValue: { _ in
                // no vlaue
            }.store(in: &cancellabels)
        }
    }
    
    func setOnline(_ isOnline: Bool) {
        user?.isActive = isOnline
        updateUserData()
    }
}
