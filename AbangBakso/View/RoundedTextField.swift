//
//  RoundedTextField.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 05/11/24.
//

import Foundation
import SwiftUI

struct RoundedTextField: View {
    @Binding var text: String

    var hint: String = ""
    var height: CGFloat = 45

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(.white)
                .stroke(.tselGrayBorder, lineWidth: 1.0)
            TextField(hint, text: $text)
                .background(.white)
                .frame(height: 48)
                .padding(EdgeInsets(top: 0, leading: 6, bottom: 0, trailing: 6))
                .cornerRadius(8)
                .tint(.gray)
                .fontBody1()
        }.frame(height: height)
    }
}
