//
//  Item.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 01/11/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date

    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
