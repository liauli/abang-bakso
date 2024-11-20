//
//  AbangBaksoApp.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 01/11/24.
//

import SwiftUI
import SwiftData
import FirebaseCore
import FirebaseFirestore

@main
struct AbangBaksoApp: App {
    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }
    }
}
