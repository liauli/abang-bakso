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
    
    private let reference: DatabaseReference
    private var observerHandle: DatabaseHandle?
    private let path: String

    init(path: String) {
        self.path = path
        self.reference = Database.database().reference().child(path)
    }

    // MARK: - Create
    func create(id: String, _ data: [String: Any]) -> AnyPublisher<Void, FirestoreError> {
        reference.child(id).setValuePublisher(data)
    }

    // MARK: - Update
    func update(id: String, _ data: [String: Any]) -> AnyPublisher<Void, FirestoreError> {
        reference.child(id).updateChildValuesPublisher(data)
    }
    
    // MARK: - Start Observing with Disconnect Handling
    func startObserving(
        query: (String, Any)? = nil,
        disconnectValue: [String: Any] = [:]
    ) -> AnyPublisher<[DocumentSnapshotWrapper], Never> {
       
        // Set the onDisconnect value if provided
        reference.onDisconnectSetValue(disconnectValue) { error, _ in
            if let error = error {
                print("Error setting onDisconnect value: \(error.localizedDescription)")
            } else {
                print("onDisconnect value set successfully.")
            }
        }
        var ref: DatabaseQuery = reference.queryOrderedByKey()
        if let query = query {
            ref = reference.queryOrdered(byChild: query.0).queryEqual(toValue: query.1)
        }
        
        // Start observing changes
        return ref.observeValuePublisher()
            .map { [weak self] (snapshots: [[String: Any]]) in
                print("==== new snap \(snapshots)")
                return snapshots.map { DocumentSnapshotWrapper(type: Collection(rawValue: self?.path ?? ""), data: $0, isExists: true) }
            }
            .replaceError(with: [])
            .eraseToAnyPublisher()
    }

    // MARK: - Stop Observing
    func stopObserving() {
        if let observerHandle = observerHandle {
            reference.removeObserver(withHandle: observerHandle)
        }
    }

    // MARK: - Delete
    func delete(id: String) -> AnyPublisher<Void, FirestoreError> {
        reference.child(id).removeValuePublisher()
    }
}
