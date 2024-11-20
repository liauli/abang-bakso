//
//  Collection.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 01/11/24.
//

import Foundation

// MARK: collection, also usertype
enum Collection: String, Codable, CaseIterable {
    case seller
    case customer
    
    func getDisplayName() -> String {
        switch self {
        case .seller:
            "Tukang Bakso"
        case .customer:
            "Customer"
        }
    }
}
