//
//  LoginRoleSelection.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 07/11/24.
//

import SwiftUI

struct LoginRoleSelection: View {
    var menus: [Collection]
    @Binding var selectedMenu: Collection?

    var body: some View {
        VStack(alignment: .leading) {
            Text("Role")
                .fontBody1()
                .padding(.bottom, 2)
            SelectableMenuView(
                selectedOption: $selectedMenu,
                options: menus,
                placeholder: String(localized: "Masukkan Role"),
                hintColor: .textFieldDefaultHint,
                selectedColor: .primaryBlack,
                backgroundColor: .white,
                borderColor: .tselGrayBorder)
            .frame(maxWidth: .infinity)
            .padding(.bottom, 4)
        }
    }
}
