//
//  Date+Ext.swift
//  AbangBakso
//
//  Created by aulia_nastiti on 19/11/24.
//

import Foundation

extension Date {
    func isAlmostEqual(to otherDate: Date, tolerance: TimeInterval = 0.01) -> Bool {
           return abs(self.timeIntervalSince(otherDate)) <= tolerance
       }
}
