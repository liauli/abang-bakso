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

    var body: some View {
        ZStack(alignment: .leading) {
            // Marker icon
            Image(type == .customer ? "customer_icon" : "seller_icon")
                .resizable()
                .frame(width: 40, height: 40)

            // Name label
            Text(name)
                .foregroundColor(.black)
                .padding(5)
                .fontLabel()
                .lineLimit(nil)
                .background(Color.white)
                .cornerRadius(10)
                .frame(maxWidth: 200)
                .fixedSize(horizontal: true, vertical: false)
                .offset(x: 45, y: -2) 
        }
    }
}
