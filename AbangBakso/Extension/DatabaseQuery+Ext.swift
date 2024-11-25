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

protocol DatabaseQueryCombine: AutoMockable {
    func observeValuePublisher() -> AnyPublisher<[[String: Any]], DatabaseError>
    func addQueryEqual(toValue value: Any) -> DatabaseQueryCombine
}

extension DatabaseQuery: DatabaseQueryCombine {
    func addQueryEqual(toValue value: Any) -> DatabaseQueryCombine {
        return self.queryEqual(toValue: value)
    }
    
    // MARK: - Observe Values
    func observeValuePublisher() -> AnyPublisher<[[String: Any]], DatabaseError> {
        let subject = PassthroughSubject<[[String: Any]], DatabaseError>()
        
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
            .handleEvents(receiveCancel: { [weak self] in
                self?.removeObserver(withHandle: handle)
            }).eraseToAnyPublisher()
    }
}
