//
//  FirestoreService.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 01/11/24.
//
import Combine
import Foundation
import FirebaseFirestore

protocol FirestoreService: AutoMockable {
    func create(id: String, _ data: [String: Any]) -> AnyPublisher<Void, FirestoreError>
    func update(id: String, _ data: [String: Any]) -> AnyPublisher<Void, FirestoreError>
    func startObserving(
        query: (String, Any)?,
        disconnectValue: [String: Any]
    ) -> AnyPublisher<[DocumentSnapshotWrapper], Never>
    func stopObserving()
    func delete(id: String) -> AnyPublisher<Void, FirestoreError>
}

class FirestoreServiceImpl: FirestoreService {
    private let ref: CollectionReference
    private var listener: ListenerRegistration?
    private let collection: Collection

    init(_ collection: Collection) {
        self.collection = collection
        ref = Firestore.firestore().collection(collection.rawValue)
    }
    
    func create(id: String, _ data: [String: Any]) -> AnyPublisher<Void, FirestoreError> {
        return ref.setDocumentIfNotExists(for: id, data: data)
    }

    func update(id: String, _ data: [String: Any]) -> AnyPublisher<Void, FirestoreError> {
        return ref.setDataPublisher(for: id, data: data)
    }

    func startObserving(
        query: (String, Any)? = nil,
        disconnectValue: [String: Any] = [:]
    ) -> AnyPublisher<[DocumentSnapshotWrapper], Never> {
        return ref.snapshotPublisher { [weak self] listener in
            self?.listener = listener
        }
        .map { querySnapshot in
            return querySnapshot.documents
                .filter { $0.data().isEmpty == false }
                .map { doc in
                    return DocumentSnapshotWrapper(type: self.collection, data: doc.data(), isExists: doc.exists)
                }
        }
        .replaceError(with: []).eraseToAnyPublisher()
    }
    
    func stopObserving() {
        listener?.remove()
    }

    func delete(id: String) -> AnyPublisher<Void, FirestoreError> {
        return ref.deleteDocument(withID: id)
    }
}
