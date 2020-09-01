//
//  main.swift
//  LedgerToTaskjuggler
//
//  Created by Ataias Pereira Reis on 01/09/20.
//

import Foundation
import LedgerToTaskjuggler

let args = CommandLine.arguments
if args.count != 6 {
    print("Usage: freepla-tj accountPrefix level ledger.timeclock fromDate ToDate")
    print("Dates should be in format yyyy-MM-dd")
    print("Only \(args.count) arguments were given.")
} else {
    let accountPrefix = args[1]
    let level = args[2]
    let ledgerFile = args[3]
    let fromDate = args[4]
    let toDate = args[5]

    var arguments = ["hledger", "-f", ledgerFile,
                     "bal", accountPrefix, level]
    arguments.append(contentsOf: ["-p", "from \(fromDate) to \(toDate)"])
    arguments.append(contentsOf: ["--daily", "-O", "csv"])

    let newBookingsStr = shell(
        launchPath: "/usr/bin/env",
        arguments: arguments)

    let newBookings = getNewBookings(from: newBookingsStr, accountPrefix: accountPrefix)
    let newBookingsForFile = createBookingLines(from: newBookings)
    print(newBookingsForFile.joined(separator: "\n"))
}
