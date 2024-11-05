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
    func startObserving() -> AnyPublisher<[DocumentSnapshot], Never>
    func stopObserving()
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
    
    func startObserving() -> AnyPublisher<[DocumentSnapshot], Never> {
        return query.snapshotPublisher { [weak self] listener in
            self?.listener = listener
        }
        .map { querySnapshot in
            return querySnapshot.documents
        }
        .replaceError(with: []).eraseToAnyPublisher()
    }
    
    func stopObserving() {
        listener?.remove()
    }
}
