//
//  ConfirmationDialog.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 13/11/24.
//

import SwiftUI


struct ConfirmationDialog: View {
    @Binding var isShowing: Bool
    
    var confirmAction: () -> () = {}
    
    var body: some View {
        if isShowing {
            ZStack(alignment: .bottom) {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all).onTapGesture {
                        isShowing = false
                    }
                VStack {
                    RoundedRectangle(cornerRadius: 8).fill(.grayGrip).frame(width: 42, height: 4).padding(.top, 14)
                    // Image
                    Image("confirmation_icon") // Replace with your image asset
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .padding(.top, 30)
                        .padding(.bottom, 20)
                    
                    // Message Text
                    Text("Dengan menutup halaman ini, kamu akan keluar dari pantauan Tukang Bakso")
                        .fontBody1()
                        .lineLimit(3)
                        .multilineTextAlignment(.center)
                        .padding([.leading, .trailing], 24)
                        .padding(.bottom, 20)
                        
                    
                    Button(action: confirmAction) {
                        Text("OK")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(.tselRed)
                            .cornerRadius(20)
                            .fontPoppins13()
                    }
                    .padding([.leading, .trailing], 20)
                    .padding(.bottom, 8)
                    
                    Button(action: {
                        // Handle Cancel action
                        
                        isShowing = false
                    }) {
                        Text("Batal")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.red)
                            .fontPoppins13()
                            .background(RoundedRectangle(cornerRadius: 20).fill(.white).stroke(.tselRed))
                    }
                    .padding([.leading, .trailing], 20)
                    .padding(.bottom, 24)
                }
                .frame(maxWidth: .infinity, maxHeight: 400)
                .background(Color.white)
                .cornerRadius(20)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
        }
    }
}

#Preview {
    ConfirmationDialog(isShowing: .constant(true))
}
