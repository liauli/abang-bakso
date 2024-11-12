//
//  Marker.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 12/11/24.
//

import SwiftUI

struct CustomMarker: View {
    var type: Collection = .customer
    var name: String
    
    var body: some View {
        ZStack {
            Image(type == .customer ? "customer_icon" : "seller_icon")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.red)
            
            GeometryReader { geometry in
                HStack {
                    Text(name)
                        .foregroundColor(.black)
                        .padding(5)
                        .fontLabel()
                        .lineLimit(1)
                        .background(Color.white)
                        .cornerRadius(10)
                        //.frame(minWidth: 0, maxWidth: .infinity)
                        .offset(x: geometry.size.width / 2 + 22, y: 5)
                }
            }
        }
    }
}

#Preview {
    CustomMarker(name: "Lia")
}
