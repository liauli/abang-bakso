//
//  File.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 10/11/24.
//

import Foundation
import Combine
import FirebaseFirestore
import CoreLocation

class LoginViewModel: ObservableObject {
    // View Input
    @Published var name: String = ""
    @Published var role: Collection?
    @Published var isTermChecked: Bool = false
    @Published var user: User?

    // View Output
    @Published private(set) var isButtonEnabled: Bool = false
    @Published private(set) var isLoggedIn: Bool = false

    private(set) var location: CLLocationCoordinate2D?

    private let createCustomerUser: CreateUser
    private let createSellerUser: CreateUser
    private let getLocationUpdates: GetLocationUpdates
    private let getCurrentUser: GetCurrentUser
    private var cancelables = Set<AnyCancellable>()

    init(_ createCustomerUser: CreateUser,
         _ createSellerUser: CreateUser,
         _ getLocationUpdates: GetLocationUpdates,
         _ getCurrentUser: GetCurrentUser
    ) {
        self.createCustomerUser = createCustomerUser
        self.createSellerUser = createSellerUser
        self.getLocationUpdates = getLocationUpdates
        self.getCurrentUser = getCurrentUser
        
        observeChangesToUpdateButtonState()
    }
}

// MARK: actions
extension LoginViewModel {
    func getCurrentLocation() {
        getLocationUpdates.execute().sink { [unowned self] location in
            if location.latitude != self.location?.latitude ?? 0 ||
                location.longitude != self.location?.longitude ?? 0 {
                self.location = location
            }
        }
        .store(in: &cancelables)
    }

    func doCreateUser() {
        if isTermChecked, let role = role {
            let user = createUserPayload(for: role)
            var domain: CreateUser = createSellerUser

            if user.type == .customer {
                domain = createCustomerUser
            }
            self.user = user
            domain.execute(user: user)
                .subscribe(on: Scheduler.background)
                .receive(on: RunLoop.main)
                .sink(receiveCompletion: { _ in
                    // no op handle error
                }, receiveValue: { [weak self] _ in
                    self?.isLoggedIn = true
                })
                .store(in: &cancelables)
        }
    }

    func destroySession() {
        user = nil
        isLoggedIn = false
    }
    
    func checkCurrentUser() {
        getCurrentUser.execute()
            .subscribe(on: Scheduler.background)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { _ in
                // no op handle error
            }, receiveValue: { [weak self] user in
                if user != nil {
                    self?.user = user
                    self?.isLoggedIn = true
                }
            })
            .store(in: &cancelables)
    }
}

// MARK: private functions
extension LoginViewModel {
    private func createUserPayload(for role: Collection) -> User {
        return User(
            type: role,
            name: name,
            location: GeoPoint(latitude: location?.latitude ?? 0, longitude: location?.longitude ?? 0),
            lastActive: Date(),
            isActive: true
        )
    }

    private func checkButtonEnabled(
        changeName: Bool = false,
        newName: String? = nil,
        changeRole: Bool = false,
        newRole: Collection? = nil,
        changeTerm: Bool = false,
        isTerm: Bool? = false
    ) {
        let nameNotEmpty = changeName ? newName?.isEmpty == false : name.isEmpty == false
        let roleSelected = changeRole ? newRole != nil : role != nil
        let isTermDoneChecked = changeTerm ? isTerm == true : isTermChecked

        isButtonEnabled = nameNotEmpty && roleSelected && isTermDoneChecked
    }

    private func observeChangesToUpdateButtonState() {
        $name.sink { [weak self] name in
            self?.checkButtonEnabled(changeName: true, newName: name)
        }.store(in: &cancelables)

        $role.sink { [weak self] role in
            self?.checkButtonEnabled(changeRole: true, newRole: role)
        }.store(in: &cancelables)

        $isTermChecked.sink { [weak self] isTerm in
            self?.checkButtonEnabled(changeTerm: true, isTerm: isTerm)
        }
        .store(in: &cancelables)
    }
}

