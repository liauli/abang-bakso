//
//  ViewModelProvider.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 11/11/24.
//

import Foundation
import FirebaseDatabase

class ViewModelProvider {
    static let shared = ViewModelProvider()
    private let domain = DomainProvider.shared
    private init() {}

    func createLoginViewModel() -> LoginViewModel {
        return LoginViewModel(
            domain.createCreateUser(type: .customer),
            domain.createCreateUser(type: .seller),
            domain.createGetLocationUpdates(),
            domain.createGetCurrentUser(type: .customer)
        )
    }

    private func createMapViewModelForSeller() -> MapViewModel {
        return MapViewModel(
            domain.createObserveUser(type: .customer),
            domain.createUpdateUser(type: .seller),
            domain.createDeleteUser(type: .seller),
            domain.createGetLocationUpdates()
        )
    }

    private func createMapViewModelForCustomer() -> MapViewModel {
        return MapViewModel(
            domain.createObserveUser(type: .seller),
            domain.createUpdateUser(type: .customer),
            domain.createDeleteUser(type: .customer)
        )
    }

    func createMapViewModel(for type: Collection) -> MapViewModel {
        switch type {
        case .customer:
            return createMapViewModelForCustomer()
        case .seller:
            return createMapViewModelForSeller()
        }
    }
}

class DomainProvider {
    static let shared = DomainProvider()
    private let repositoryProvider = RepositoryProvider.shared

    private init() {

    }
    func createGetLocationUpdates() -> GetLocationUpdates {
        return GetLocationUpdatesImpl(repositoryProvider.createLocationRepository())
    }

    func createCreateUser(type: Collection) -> CreateUser {
        return CreateUserImpl(repositoryProvider.createUserRepository(type: type))
    }

    func createObserveUser(type: Collection) -> ObserveUser {
        return ObserveUserImpl(repositoryProvider.createUserRepository(type: type))
    }

    func createUpdateUser(type: Collection) -> UpdateUser {
        return UpdateUserImpl(repositoryProvider.createUserRepository(type: type))
    }

    func createDeleteUser(type: Collection) -> DeleteUser {
        return DeleteUserImpl(
            repositoryProvider.createUserRepository(type: type)
        )
    }
    
    func createGetCurrentUser(type: Collection) -> GetCurrentUser {
        return GetCurrentUserImpl(
            repositoryProvider.createUserRepository(type: type)
        )
    }
}

class RepositoryProvider {
    static let shared = RepositoryProvider()
    private let serviceProvider = ServiceProvider.shared
    private init() {

    }

    func createLocationRepository() -> LocationRepository {
        return LocationRepositoryImpl()
    }
    func createUserRepository(type: Collection) -> UserRepository {
        return UserRepositoryImpl(
            serviceProvider.createRealtimeDatabaseService(type: type.rawValue),
            serviceProvider.createKeychainFacade()
        )
    }
}

class ServiceProvider {
    static let shared = ServiceProvider()
    
    private var keychainFacade: KeychainFacade? = nil
    private var realtimeDatabaseService: DatabaseService? = nil

    private init() {

    }

    func createKeychainFacade() -> KeychainFacade {
        guard let keychainFacade = keychainFacade else {
            let instance = KeychainFacadeImpl()
            self.keychainFacade = instance
            return instance
        }
        return keychainFacade
    }
    
    func createRealtimeDatabaseService(type: String) -> DatabaseService {
        guard let db = realtimeDatabaseService else {
            return RealtimeDatabaseServiceImpl(
                reference: createFirebaseDatabase(type: type),
                path: type)
        }
        return db
        
    }
    
    private func createFirebaseDatabase(type: String) -> DatabaseReferenceCombine {
        return Database.database().reference().child(type)
    }
}
