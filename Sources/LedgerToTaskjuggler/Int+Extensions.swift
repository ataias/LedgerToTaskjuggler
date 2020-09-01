//
//  Int+Extensions.swift
//  ledger-to-tj
//
//  Created by Ataias Pereira Reis on 01/09/20.
//

import Foundation

extension Int {
    func roundInt(by: Int) -> Int {
        if self == 0 {
            return 0
        } else {
            return Int((round(Double(self) / Double(by))))*by
        }
    }
}
