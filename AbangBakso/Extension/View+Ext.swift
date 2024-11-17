//
//  View+Ext.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 05/11/24.
//

import Foundation
import SwiftUI

extension View {
    func fontBatikTselH4() -> some View {
        self.font(.custom("TelkomselBatikSans-Regular", size: 24))
    }

    func fontBatikTselH4Bold() -> some View {
        self.font(.custom("TelkomselBatikSans-Bold", size: 24))
    }

    func fontBody2() -> some View {
        self.font(.custom("Poppins-Regular", size: 12))
    }

    func fontBody1() -> some View {
        self.font(.custom("Poppins-Regular", size: 14))
    }

    func fontLabel() -> some View {
        self.font(.custom("Poppins-Regular", size: 10))
    }

    func fontPoppins13() -> some View {
        self.font(.custom("Poppins-Regular", size: 13))
    }
}

