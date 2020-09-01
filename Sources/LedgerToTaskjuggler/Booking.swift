//
//  Booking.swift
//  ledger-to-tj
//
//  Created by Ataias Pereira Reis on 01/09/20.
//

import Foundation

public struct Booking {
    let account: String
    let date: String
    let hourDuration: Double

    static let dateFormatter: DateFormatter = { (format:String) in
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = format
        return formatter
    }("yyyy-MM-dd")

}
