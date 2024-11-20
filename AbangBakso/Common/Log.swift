//
//  Log.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 20/11/24.
//

import Foundation

func log(_ message: String) {
    #if DEBUG
    print(message)
    #endif
}
