//
//  ViewModelProvider.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 11/11/24.
//

import Foundation

class ViewModelProvider {
    static let shared = ViewModelProvider()
    private let domain = DomainProvider.shared
    private init() {
        
    }
    
    func createLoginViewModel() -> LoginViewModel {
        return LoginViewModel(
            domain.createCreateUser(type: .customer),
            domain.createCreateUser(type: .seller), 
            domain.createGetLocationUpdates()
        )
    }
    
    func createMapViewModel() -> MapViewModel {
        return MapViewModel(
            domain.createObserveUser(type: .customer),
            RepositoryProvider.shared.createUserRepository(type: .seller)
        )
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
            serviceProvider.createFirestoreService(type: type),
            serviceProvider.createKeychainFacade()
        )
    }
}


class ServiceProvider {
    static let shared = ServiceProvider()
    
    private init() {
        
    }
    
    func createFirestoreService(type: Collection) -> FirestoreService {
        return FirestoreServiceImpl(type)
    }
    
    func createKeychainFacade() -> KeychainFacade {
        return KeychainFacadeImpl()
    }
}
