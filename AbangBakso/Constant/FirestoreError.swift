//
//  FirestoreError.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 01/11/24.
//

import Foundation

enum FirestoreError: Error, Equatable {
    
    case documentExists
    case snapshotError(_ error: Error)
    case modelInitializationFailed
    case unknownType
    case failedToSaveUser
    case failedToGetUser
    case generalError(_ error: Error)
    
    static func == (lhs: FirestoreError, rhs: FirestoreError) -> Bool {
            switch (lhs, rhs) {
            case (.documentExists, .documentExists):
                return true
            case (.snapshotError(let lhsError), .snapshotError(let rhsError)):
                return lhsError.localizedDescription == rhsError.localizedDescription
            case (.modelInitializationFailed, .modelInitializationFailed):
                return true
            case (.unknownType, .unknownType):
                return true
            case (.failedToSaveUser, .failedToSaveUser):
                return true
            case (.failedToGetUser, .failedToGetUser):
                return true
            case (.generalError(let lhsError), .generalError(let rhsError)):
                return lhsError.localizedDescription == rhsError.localizedDescription
            default:
                return false
            }
        }
}
