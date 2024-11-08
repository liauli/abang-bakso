//
//  ContentView.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 01/11/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {

    var body: some View {
        LoginView()
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
