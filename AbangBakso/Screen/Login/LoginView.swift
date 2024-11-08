//
//  LoginView.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 05/11/24.
//

import SwiftUI

struct LoginView: View {
    @State var name: String = ""
    @State var isChecked: Bool = false
    
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
    }
    
    private var loginHeader: some View {
        VStack {
            Image("login_img")
            Text("Verifikasi").fontBatikTselH4()
        }
    }
    
    private var loginForm: some View {
        VStack {
            LoginField(text: $name, label: "Nama", hint: "Nama").padding(.top, 16)
            LoginField(text: $name, label: "Role", hint: "Role")
            
            Button {
                
            } label: {
                Text("Join")
                    .fontBody1()
                    .frame(maxWidth: .infinity, maxHeight: 40)
            }
            .cornerRadius(20)
            .buttonStyle(.borderedProminent)
            .tint(.tselRed)
            
            CheckboxView(
                isChecked: $isChecked,
                label: String(localized: "login_checkbox_text"))
                .padding(.vertical, 16)
        }
    }
}

#Preview {
    LoginView()
}
