//
//  CharacterLimitModifier.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 17/11/24.
//

import Combine
import Foundation
import SwiftUI

struct CharacterLimitModifier: ViewModifier {
    @Binding var text: String
    var limit: Int

    func body(content: Content) -> some View {
        content
            .onReceive(Just(text)) { _ in
                if text.count > limit {
                    text = String(text.prefix(limit))
                }
            }
    }
}

extension View {
    func characterLimit(_ text: Binding<String>, limit: Int) -> some View {
        self.modifier(CharacterLimitModifier(text: text, limit: limit))
    }
}
