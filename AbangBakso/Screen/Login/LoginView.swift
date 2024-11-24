//
//  LoginView.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 05/11/24.
//

import SwiftUI

struct LoginView: View {
    let userTypes = Collection.allCases

    @ObservedObject var loginVM: LoginViewModel

    var body: some View {
        VStack {
            LoginHeader()
            VStack(alignment: .leading) {
                VStack {
                    loginUsernameField
                    loginRoleSelection
                    joinButton
                    checkBoxView
                }.padding(.horizontal, 16)
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
    
    private var loginUsernameField: some View {
        LoginField(
            text: $loginVM.name,
            label: String(localized: "Nama"),
            hint: String(localized: "Masukkan Nama"))
        .padding(.top, 16)
    }
    
    private var loginRoleSelection: some View {
        LoginRoleSelection(menus: userTypes, selectedMenu: $loginVM.role)
    }
    
    private var joinButton: some View {
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
        .disabled(!loginVM.isButtonEnabled)
    }
    
    private var checkBoxView: some View {
        CheckboxView(
            isChecked: $loginVM.isTermChecked,
            label: String(localized: "login_checkbox_text"))
            .padding(.vertical, 16)
    }
}
