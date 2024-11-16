//
//  CheckboxView.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 05/11/24.
//

import Foundation
import SwiftUI

struct CheckboxView: View {
    @Binding var isChecked: Bool
    var label: String

    var body: some View {
        Button(action: {
            isChecked.toggle()
        }, label: {
            checkView
        })
        .buttonStyle(PlainButtonStyle()) // Remove default button styling
    }

    private var checkView: some View {
        HStack {
            Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                .foregroundColor(isChecked ? .blue : .gray)
                .font(.system(size: 20))

            Text(label)
                .foregroundColor(.primaryBlack)
                .fontLabel()
        }
    }
}
