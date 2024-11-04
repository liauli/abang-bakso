//
//  FirestoreError.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 01/11/24.
//

import Foundation

enum FirestoreError: Error {
    case documentExists
    case snapshotError(_ error: Error)
    case modelInitializationFailed
    case unknownType
    case failedToSaveUser
    case failedToGetUser
    case generalError(_ error: Error)
}
