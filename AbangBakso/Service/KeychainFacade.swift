//
//  KeychainFacade.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 04/11/24.
//


import Foundation

/*
 reference:
 https://www.linkedin.com/learning/ios-development-security/keychain-overview?resume=false&u=127623298
 https://github.com/twostraws/HackingWithSwift/blob/main/Classic/project28-files/KeychainWrapper.swift
 */

enum KeychainFacadeError: Error {
    case invalidContent
    case failure(status: OSStatus)
}

// MARK: Set
protocol KeychainFacade {
    //set
    func set(data: Data, forKey key: String) throws
    func set(data: Bool, forKey key: String) throws
    func set(data: String, forKey key: String) throws
    func set(data: Int, forKey key: String) throws
    
    //get
    func get(forKey key: String) throws -> Data?
    func string(forKey key: String) throws -> String?
    func int(forKey key: String) throws -> Int?
    
    //remove
    func remove(forKey key: String) throws
}

// MARK: Set
class KeychainFacadeImpl: KeychainFacade {
    func set(data: Data, forKey key: String) throws {
        guard !data.isEmpty && !key.isEmpty else {
            throw KeychainFacadeError.invalidContent
        }
        //MARK: use `update` instead of `remove`
        
        var query = createQuery(forKey: key)
        query[kSecValueData as String] = data
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status == errSecDuplicateItem {
            try update(data, forKey: key)
        } else {
            try checkError(status: status)
        }
    }
    
    func set(data: Bool, forKey key: String) throws {
        let dataToStore = String(data).data(using: .utf8)
        guard let dataToStore else {
            throw KeychainFacadeError.invalidContent
        }
        try set(data: dataToStore, forKey: key)
    }
    
    func set(data: String, forKey key: String) throws {
        let dataToStore = data.data(using: .utf8)
        guard let dataToStore else {
            throw KeychainFacadeError.invalidContent
        }
        try set(data: dataToStore, forKey: key)
    }
    
    func set(data: Int, forKey key: String) throws {
        let dataToStore = String(data).data(using: .utf8)
        guard let dataToStore else {
            throw KeychainFacadeError.invalidContent
        }
        try set(data: dataToStore, forKey: key)
    }
    
}

// MARK: Get
extension KeychainFacadeImpl {
    func get(forKey key: String) throws -> Data? {
        guard !key.isEmpty else {
            throw KeychainFacadeError.invalidContent
        }
        var query = createQuery(forKey: key)
        query[kSecReturnData as String] = kCFBooleanTrue
        query[kSecMatchLimit as String] = kSecMatchLimitOne
        
        var data: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &data)
        
        try checkError(status: status)
        
        return data as? Data
    }
    
    func string(forKey key: String) throws -> String? {
        let data = try get(forKey: key)
        
        var result: String? = nil
        if let itemData = data {
            result = String(data: itemData, encoding: .utf8)
        }
        
        return result
    }
    
    func int(forKey key: String) throws -> Int? {
        let data = try get(forKey: key)
        
        var result: Int? = nil
        if let itemData = data, let itemString = String(data: itemData, encoding: .utf8) {
            result = Int(itemString)
        }
        
        return result
    }
}

// MARK: remove
extension KeychainFacadeImpl {
    func remove(forKey key: String) throws {
        guard !key.isEmpty else {
            throw KeychainFacadeError.invalidContent
        }
        let query = createQuery(forKey: key)
        
        let status = SecItemDelete(query as CFDictionary)
        try checkError(status: status)
    }
}

// MARK: update
extension KeychainFacadeImpl {
    fileprivate func update(_ value: Data, forKey key: String) throws {
        let query = createQuery(forKey: key)
        let updateDictionary = [kSecValueData: value]
            
        let status = SecItemUpdate(query as CFDictionary, updateDictionary as CFDictionary)
        if status != errSecSuccess {
            throw KeychainFacadeError.failure(status: status)
        }
    }
}

// MARK: private functions
extension KeychainFacadeImpl {
    fileprivate func createQuery(forKey key: String) -> [String: Any] {
        var query: [String: Any] = [kSecClass as String: kSecClassGenericPassword]
        
        query[kSecAttrAccount as String] = key.data(using: .utf8)
        
        return query
    }
    
    fileprivate func checkError(status: OSStatus) throws {
        if status != errSecSuccess {
            throw KeychainFacadeError.failure(status: status)
        }
    }
}
