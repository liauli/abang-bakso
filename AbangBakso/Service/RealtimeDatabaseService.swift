//
//  RealtimeDatabaseService.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 19/11/24.
//

import Combine
import Foundation
import FirebaseDatabase

class RealtimeDatabaseServiceImpl: FirestoreService {
    var observeHandle: DatabaseHandle? = nil
    private let reference: DatabaseReferenceCombine
    private let path: String

    init(reference: DatabaseReferenceCombine, path: String) {
        self.path = path
        self.reference = reference
    }

    // MARK: - Create
    func create(id: String, _ data: [String: Any]) -> AnyPublisher<Void, FirestoreError> {
        reference.addChild(id).setValuePublisher(data)
    }

    // MARK: - Update
    func update(id: String, _ data: [String: Any]) -> AnyPublisher<Void, FirestoreError> {
        reference.addChild(id).updateChildValuesPublisher(data)
    }
    
    // MARK: - Start Observing with Disconnect Handling
    func startObserving(
        query: (String, Any)? = nil,
        disconnectValue: [String: Any] = [:]
    ) -> AnyPublisher<[DocumentSnapshotWrapper], Never> {
        // Offline value
        handleOffline(disconnectValue)
        
        // set query conditions
        var ref: DatabaseQueryCombine = reference.addQueryOrderedByKey()
        if let query = query {
            ref = reference
                .addQueryOrdered(byChild: query.0)
                .addQueryEqual(toValue: query.1)
        }
        
        return ref.observeValuePublisher()
            .map { [weak self] (snapshots: [[String: Any]]) in
                guard let self = self else { return [] }
                return snapshots.map {
                    DocumentSnapshotWrapper(
                        type: Collection(rawValue: self.path),
                        data: $0,
                        isExists: true)
                }
            }
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }
    
    private func handleOffline(_ disconnectValue: [String: Any]) {
        reference.addOnDisconnectSetValue(disconnectValue) { error, _ in
            if let error = error {
                log("Error setting onDisconnect value: \(error.localizedDescription)")
            } else {
                log("onDisconnect value set successfully.")
            }
        }
    }

    // MARK: - Stop Observing
    func stopObserving() {
        if let handle = observeHandle {
            reference.removeObservers()
        }
    }

    // MARK: - Delete
    func delete(id: String) -> AnyPublisher<Void, FirestoreError> {
        reference.addChild(id).removeValuePublisher()
    }
}
