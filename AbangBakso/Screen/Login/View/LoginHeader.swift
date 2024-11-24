//
//  LoginHeader.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 20/11/24.
//

import Foundation
import SwiftUI

struct LoginHeader: View {
    var body: some View {
        VStack {
            Image("login_img")
            Text("Verifikasi").fontBatikTselH4Bold()
            Text("Masukkan nama dan role Anda di bawah ini:").fontBody2()
        }
    }
}
