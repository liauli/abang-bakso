//
//  LoginField.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 05/11/24.
//

import SwiftUI

struct LoginField: View {
    @Binding var text: String
    var label: String
    var hint: String

    var body: some View {
        VStack(alignment: .leading) {
            Text(label)
                .fontBody1()
                .padding(.bottom, 2)
            RoundedTextField(
                text: $text,
                hint: hint,
                height: 45
            ).padding(.bottom, 4)
        }
    }
}
