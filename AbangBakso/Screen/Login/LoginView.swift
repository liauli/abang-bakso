//
//  LoginView.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 05/11/24.
//

import SwiftUI

struct LoginView: View {
    let userTypes = Collection.allCases.map { $0.rawValue }

    @ObservedObject var loginVM: LoginViewModel

    var body: some View {
        VStack {
            loginHeader
            VStack(alignment: .leading) {
                loginForm.padding(.horizontal, 16)
            }
            .background(.tselLightGrayBg)
            .border(.white, width: 1)
            .cornerRadius(20)
            .padding(24)
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.tselGrayBg)
        .onAppear {
            loginVM.getCurrentLocation()
        }
    }

    private var loginHeader: some View {
        VStack {
            Image("login_img")
            Text("Verifikasi").fontBatikTselH4Bold()
            Text("Masukkan nama dan role Anda di bawah ini:").fontBody2()
        }
    }

    private var loginForm: some View {
        VStack {
            LoginField(
                text: $loginVM.name,
                label: String(localized: "Nama"),
                hint: String(localized: "Masukkan Nama"))
            .padding(.top, 16)
            LoginRoleSelection(menus: userTypes, selectedMenu: $loginVM.role)

            Button {
                loginVM.doCreateUser()
            } label: {
                Text("Join")
                    .fontBody1()
                    .frame(maxWidth: .infinity, maxHeight: 40)
            }
            .cornerRadius(20)
            .buttonStyle(.borderedProminent)
            .tint(.tselRed)
            .disabled(!loginVM.isTermChecked)

            CheckboxView(
                isChecked: $loginVM.isTermChecked,
                label: String(localized: "login_checkbox_text"))
                .padding(.vertical, 16)
        }
    }
}

// #Preview {
    // LoginView()
// }
