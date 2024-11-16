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

    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }
        .modelContainer(sharedModelContainer)
    }
}
