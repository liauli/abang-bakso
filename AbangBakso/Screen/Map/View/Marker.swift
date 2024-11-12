//
//  Marker.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 12/11/24.
//

import SwiftUI

struct Marker: View {
    var type: Collection = .customer
    var name: String
    
    var body: some View {
        ZStack(alignment: .center) {
            Image("customer_icon")
                .resizable()
                .frame(width: 40, height: 40)
                .foregroundColor(.red)
            
            Text(name)
                .foregroundColor(.black)
                .padding(5)
                .fontLabel()
                .lineLimit(1)
                .background(Color.white)
                .cornerRadius(10)
                .frame(minWidth: 0, maxWidth: .infinity)
                .offset(x: 66, y: -3)

        }
    }
}

#Preview {
    Marker(name: "Lia")
}
