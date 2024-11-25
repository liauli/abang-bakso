//
//  DatabaseReference+Ext.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 24/11/24.
//

import Combine
import Foundation
import FirebaseDatabase

protocol DatabaseReferenceCombine: AutoMockable {
    func addChild(_ path: String) -> DatabaseReferenceCombine
    func setValuePublisher(_ data: [String: Any]) -> AnyPublisher<Void, DatabaseError>
    func updateChildValuesPublisher(_ data: [String: Any]) -> AnyPublisher<Void, DatabaseError>
    func removeValuePublisher() -> AnyPublisher<Void, DatabaseError>
    func setupPresencePublisher(onlineValue: Any, offlineValue: Any) -> AnyPublisher<Void, DatabaseError>
    func addQueryOrderedByKey() -> DatabaseQueryCombine
    func addQueryOrdered(byChild key: String) -> DatabaseQueryCombine
    func addOnDisconnectSetValue(_ value: Any, completion: @escaping (Error?, DatabaseReference?) -> Void)
    func removeObservers()
}

extension DatabaseReference: DatabaseReferenceCombine {
    func removeObservers() {
        self.removeAllObservers()
    }
    
    func addOnDisconnectSetValue(_ value: Any, completion: @escaping (Error?, DatabaseReference?) -> Void) {
        return self.onDisconnectSetValue(value, withCompletionBlock: completion)
    }
    
    func addQueryOrderedByKey() -> DatabaseQueryCombine {
        return self.queryOrderedByKey()
    }
    
    func addQueryOrdered(byChild key: String) -> DatabaseQueryCombine {
        return self.queryOrdered(byChild: key)
    }
    
    func addChild(_ path: String) -> DatabaseReferenceCombine {
        return self.child(path)
    }
    
    // MARK: - Set Value
    func setValuePublisher(_ data: [String: Any]) -> AnyPublisher<Void, DatabaseError> {
        return Future<Void, DatabaseError> { [weak self] promise in
            self?.setValue(data) { error, _ in
                if let error = error {
                    promise(.failure(.generalError(error)))
                } else {
                    promise(.success(()))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    // MARK: - Update Value
    func updateChildValuesPublisher(_ data: [String: Any]) -> AnyPublisher<Void, DatabaseError> {
        Future<Void, DatabaseError> { [weak self] promise in
            self?.updateChildValues(data) { error, _ in
                if let error = error {
                    promise(.failure(.generalError(error)))
                } else {
                    promise(.success(()))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    // MARK: - Remove Value
    func removeValuePublisher() -> AnyPublisher<Void, DatabaseError> {
        Future<Void, DatabaseError> { [weak self] promise in
            self?.removeValue { error, _ in
                if let error = error {
                    promise(.failure(.generalError(error)))
                } else {
                    promise(.success(()))
                }
            }
        }
        .eraseToAnyPublisher()
    }

    // MARK: - Presence Feature
    /// Sets up presence for the current user.
    /// - Parameters:
    ///   - onlineValue: The value to set when the user is online (e.g., `"online"` or a timestamp).
    ///   - offlineValue: The value to set when the user disconnects (e.g., `"offline"` or a timestamp).
    func setupPresencePublisher(onlineValue: Any, offlineValue: Any) -> AnyPublisher<Void, DatabaseError> {
        Future<Void, DatabaseError> { [weak self] promise in
            // Set the online value
            self?.setValue(onlineValue) { [weak self] error, _ in
                if let error = error {
                    promise(.failure(.generalError(error)))
                    return
                }

                // Set the offline value on disconnect
                self?.onDisconnectSetValue(offlineValue) { error, _ in
                    if let error = error {
                        promise(.failure(.generalError(error)))
                    } else {
                        promise(.success(()))
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }

}
