//
//  ContentView.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 01/11/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @StateObject var loginVM = ViewModelProvider.shared.createLoginViewModel()

    var body: some View {
        if loginVM.isLoggedIn {
            if let user = loginVM.user {
                MapView(user: user, mapVM: ViewModelProvider.shared.createMapViewModel(for: user.type))
                    .environmentObject(loginVM)
            }
        } else {
            LoginView(loginVM: loginVM)
                .onAppear {
                    loginVM.checkCurrentUser()
                }
        }
    }
}
