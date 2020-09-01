//
//  main.swift
//  LedgerToTaskjuggler
//
//  Created by Ataias Pereira Reis on 01/09/20.
//

import Foundation
import ledger_to_tj

let args = CommandLine.arguments
if args.count != 5 {
    print("Usage: freepla-tj period accountPrefix level ledger.timeclock bookings.tji")
} else {
    let accountPrefix = args[1]
    let level = args[2]
    let ledgerFile = args[3]

    var arguments = [ "-f", ledgerFile,
                   "bal", accountPrefix, level]
//    if let (fromDate, toDate) = getDateRange(bookingsFilename: args[4]) {
        // arguments.append(contentsOf: ["-p", "from \(fromDate) to \(toDate)"])
        arguments.append(contentsOf: ["-p", "this week"])
//    }
    arguments.append(contentsOf: ["--daily", "-O", "csv"])

    let newBookingsStr = shell(
      launchPath: "/usr/local/bin/hledger",
      arguments: arguments)

    let newBookings = getNewBookings(from: newBookingsStr, accountPrefix: accountPrefix)
    let newBookingsForFile = createBookingLines(from: newBookings)
    print(newBookingsForFile.joined(separator: "\n"))
}
