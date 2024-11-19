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
extension DatabaseReference {
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


extension DatabaseQuery {
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
