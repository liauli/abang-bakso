//
//  RealtimeDatabase+Ext.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 19/11/24.
//

import Foundation

import Combine
import FirebaseDatabase

enum RealtimeDatabaseError: Error {
    case decodingError
    case unknownError
    case firebaseError(String)
}

protocol DatabaseReferenceCombine: AutoMockable {
    func addChild(_ path: String) -> DatabaseReferenceCombine
    func setValuePublisher(_ data: [String: Any]) -> AnyPublisher<Void, FirestoreError>
    func updateChildValuesPublisher(_ data: [String: Any]) -> AnyPublisher<Void, FirestoreError>
    func removeValuePublisher() -> AnyPublisher<Void, FirestoreError>
    func setupPresencePublisher(onlineValue: Any, offlineValue: Any) -> AnyPublisher<Void, FirestoreError>
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
    func setValuePublisher(_ data: [String: Any]) -> AnyPublisher<Void, FirestoreError> {
        return Future<Void, FirestoreError> { promise in
            self.setValue(data) { error, _ in
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
    func updateChildValuesPublisher(_ data: [String: Any]) -> AnyPublisher<Void, FirestoreError> {
        Future<Void, FirestoreError> { promise in
            self.updateChildValues(data) { error, _ in
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
    func removeValuePublisher() -> AnyPublisher<Void, FirestoreError> {
        Future<Void, FirestoreError> { promise in
            self.removeValue { error, _ in
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
    func setupPresencePublisher(onlineValue: Any, offlineValue: Any) -> AnyPublisher<Void, FirestoreError> {
        Future<Void, FirestoreError> { promise in
            // Set the online value
            self.setValue(onlineValue) { error, _ in
                if let error = error {
                    promise(.failure(.generalError(error)))
                    return
                }

                // Set the offline value on disconnect
                self.onDisconnectSetValue(offlineValue) { error, _ in
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

protocol DatabaseQueryCombine: AutoMockable {
    func observeValuePublisher() -> AnyPublisher<[[String: Any]], FirestoreError>
    func addQueryEqual(toValue value: Any) -> DatabaseQueryCombine
}

extension DatabaseQuery: DatabaseQueryCombine {
    func addQueryEqual(toValue value: Any) -> DatabaseQueryCombine {
        return self.queryEqual(toValue: value)
    }
    
    // MARK: - Observe Values
    func observeValuePublisher() -> AnyPublisher<[[String: Any]], FirestoreError> {
        let subject = PassthroughSubject<[[String: Any]], FirestoreError>()
        
        let handle = self.observe(.value, with: { snapshot in
            var results: [[String: Any]] = []
            if let children = snapshot.children.allObjects as? [DataSnapshot] {
                for child in children {
                    if let value = child.value as? [String: Any] {
                        results.append(value)
                    }
                }
            }
            subject.send(results)
        }, withCancel: { error in
            subject.send(completion: .failure(.generalError(error)))
        })
        
        // Return a publisher and manage the observer handle
        return subject
            .handleEvents(receiveCancel: {
                self.removeObserver(withHandle: handle)
            }).eraseToAnyPublisher()
    }
}
