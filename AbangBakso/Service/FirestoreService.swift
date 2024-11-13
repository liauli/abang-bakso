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
    func startObserving() -> AnyPublisher<[DocumentSnapshotWrapper], Never>
    func stopObserving()
    func delete(id: String) -> AnyPublisher<Void, FirestoreError>
}

class FirestoreServiceImpl: FirestoreService {
    private let query: CollectionReference
    private var listener: ListenerRegistration? = nil
    
    // TODO: add limit and filters
    init(_ collection: Collection) {
        query = Firestore.firestore().collection(collection.rawValue)
    }
    func create(id: String, _ data: [String: Any]) -> AnyPublisher<Void, FirestoreError> {
        return query.setDocumentIfNotExists(for: id, data: data)
    }
    
    func update(id: String, _ data: [String: Any]) -> AnyPublisher<Void, FirestoreError> {
        return query.setDataPublisher(for: id, data: data)
    }
    
    func startObserving() -> AnyPublisher<[DocumentSnapshotWrapper], Never> {
        return query.whereField("isActive", isEqualTo: true).snapshotPublisher { [weak self] listener in
            self?.listener = listener
        }
        .map { querySnapshot in
            return querySnapshot.documents
                .filter{ $0.data().isEmpty == false }
                .map { doc in
                    return DocumentSnapshotWrapper(data: doc.data(), isExists: doc.exists)
                }
        }
        .replaceError(with: []).eraseToAnyPublisher()
    }
    
    func stopObserving() {
        listener?.remove()
    }
    
    func delete(id: String) -> AnyPublisher<Void, FirestoreError> {
        return query.deleteDocument(withID: id)
    }
}
