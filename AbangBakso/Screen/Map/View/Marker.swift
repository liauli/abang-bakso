//
//  Marker.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 12/11/24.
//

import SwiftUI
struct CustomMarker: View {
    var type: Collection
    var name: String

    @State private var textWidth: CGFloat = 0 // Tracks the text width dynamically

    var body: some View {
        ZStack {
            // Name label
            Text(name)
                .foregroundColor(.black)
                .padding(5)
                .fontLabel()
                .lineLimit(nil)
                .background(Color.white)
                .cornerRadius(10)
                .frame(maxWidth: 300)
                .fixedSize(horizontal: true, vertical: false)
                .background(GeometryReader { geometry in
                    // Measure the width of the text
                    Color.clear
                        .onAppear {
                            textWidth = geometry.size.width
                        }
                })
                .offset(x: textWidth / 2 + 16, y: -2) // Position based on text width

            // Marker icon
            Image(type == .customer ? "customer_icon" : "seller_icon")
                .resizable()
                .frame(width: 40, height: 40)
        }
    }
}
