//
//  SelectableMenu.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 07/11/24.
//

import SwiftUI

struct SelectableMenuView: View {
    @Binding var selectedOption: String?
    let options: [String]
    let placeholder: String
    let hintColor: Color
    let selectedColor: Color
    let backgroundColor: Color
    let borderColor: Color

    var body: some View {
        HStack {
            Menu {
                ForEach(options, id: \.self) { option in
                    Button(action: {
                        selectedOption = option
                    }, label: {
                        Text(option)
                            .foregroundColor(.primary) // Or your custom color
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(RoundedRectangle(cornerRadius: 8).fill(Color.white))
                    })
                }
            } label: {
                Text(selectedOption != nil ? selectedOption ?? "" : placeholder)
                    .foregroundColor(selectedOption == nil ? hintColor : selectedColor) // Use hintColor for unselected
                    .padding(.vertical)
                    .padding(.leading, 8)
                    .padding(.trailing)
                    .fontBody1()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(RoundedRectangle(cornerRadius: 8).fill(backgroundColor).stroke(borderColor))

            }
        }
        .frame(maxWidth: .infinity)
    }
}
