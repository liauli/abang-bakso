//
//  Firestore+Ext.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 01/11/24.
//

import Combine
import Foundation
import FirebaseFirestore

extension DocumentReference {
    func setDataPublisher(data: [String: Any]) -> AnyPublisher<Void, Error> {
        Future { promise in
            self.setData(data) { error in
                if let error = error {
                    promise(.failure(error))
                } else {
                    promise(.success(()))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}

extension CollectionReference {
    func setDataPublisher(for id: String, data: [String: Any], merge: Bool = true) -> AnyPublisher<Void, FirestoreError> {
        Future { promise in
            self.document(id).setData(data, merge: merge) { error in
                if let error = error {
                    promise(.failure(FirestoreError.snapshotError(error)))
                } else {
                    promise(.success(()))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func setDocumentIfNotExists(for id: String, data: [String: Any]) -> AnyPublisher<Void, FirestoreError> {
            let documentRef = self.document(id)
            
            return Future { promise in
                // Check if document already exists
                documentRef.getDocument { snapshot, error in
                    if let error = error {
                        promise(.failure(FirestoreError.snapshotError(error)))
                    } else if snapshot?.exists == true {
                        // Document already exists, return a custom error
                        promise(.failure(FirestoreError.documentExists))
                    } else {
                        // Document does not exist, proceed with adding it
                        documentRef.setData(data) { error in
                            if let error = error {
                                promise(.failure(FirestoreError.snapshotError(error)))
                            } else {
                                promise(.success(()))
                            }
                        }
                    }
                }
            }
            .eraseToAnyPublisher()
        }
}

extension Query {
    func snapshotPublisher(listenerReg: @escaping (ListenerRegistration) -> Void) -> AnyPublisher<QuerySnapshot, FirestoreError> {
        let subject = PassthroughSubject<QuerySnapshot, FirestoreError>()
        
        let listener = self.addSnapshotListener { snapshot, error in
            if let error = error {
                subject.send(completion: .failure(.snapshotError(error)))
            } else if let snapshot = snapshot {
                subject.send(snapshot)
            }
        }
        
        listenerReg(listener)
        
        return subject
            .handleEvents(receiveCancel: {
                listener.remove()
            })
            .eraseToAnyPublisher()
    }
                
}
