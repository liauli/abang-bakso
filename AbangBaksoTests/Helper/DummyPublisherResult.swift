//
//  DummyPublisherResult.swift
//  AbangBaksoTests
//
//  Created by aulia_nastiti on 04/11/24.
//

import Combine
import Foundation
import SwiftyMocky

@testable import AbangBakso

func success<T>(_ data: T) -> AnyPublisher<T, FirestoreError> {
  return Just(data).setFailureType(to: FirestoreError.self).eraseToAnyPublisher()
}

func failed<T>(_ error: FirestoreError) -> AnyPublisher<T, FirestoreError> {
  return Fail(error: error).eraseToAnyPublisher()
}

func registerMatcher() {
    Matcher.default.register([String: Any].self) { (lhs, rhs) -> Bool in
        return areDictionariesEqual(lhs, rhs)
    }
}

func areDictionariesEqual(_ dict1: [String: Any], _ dict2: [String: Any]) -> Bool {
    // Check if they have the same number of keys
    guard dict1.count == dict2.count else {
        return false
    }

    // Compare each key and value
    for (key, value1) in dict1 {
        // Check if dict2 has the same key
        guard let value2 = dict2[key] else {
            return false
        }

        // Check if values are equal, handle different types
        if String(describing: value1) != String(describing: value2) {
            return false
        }
    }
    return true
}
