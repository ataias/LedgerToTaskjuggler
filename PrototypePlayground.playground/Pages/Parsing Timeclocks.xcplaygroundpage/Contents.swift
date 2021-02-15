//: [Previous](@previous)

import Foundation

let data = """
i 2020-01-21 16:30:00 BA:DRAWBRIDGE  Updating GTD, replying messages
o 2020-01-21 17:00:00
i 2020-01-21 17:00:00 BA:DRAWBRIDGE  - Debug code with Person X - Talk with Person Y
o 2020-01-21 18:30:00


i 2021-02-11 11:45:00 BA:POS8:I26  Review translated procedures and set up tests for actual repo
o 2021-02-11 12:15:00

i 2021-02-11 12:35:00 BA:POS8:I26  Review translated procedures and set up tests for actual repo
o 2021-02-11 18:00:00

i 2021-02-11 18:30:00 PERSONAL:FRENCH  Duolingo and Lingvist
o 2021-02-11 19:00:00
"""

struct RawTimeEntry {
//    /// A line in the clock in format from ledger:
//    /// i <TIMESTAMP> <ACCOUNT>  <DESCRIPTION>
//    ///
//    /// An example is available below:
//    /// i 2020-01-21 16:30:00 BA:DRAWBRIDGE  Updating GTD, replying messages
//    let clockIn: String
//
//    /// A line in the clock out format from ledger:
//    /// o <TIMESTAMP>
//    ///
//    /// An example is available below:
//    /// o 2020-01-21 17:00:00
//    let clockOut: String

    init(clockIn: String, clockOut: String) {
        let inComponents = clockIn
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: "  ")
        self.description = inComponents[1]

        let inTimeComponents = inComponents[0]
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: " ")
        self.startTime = "\(inTimeComponents[1]) \(inTimeComponents[2])"
        self.account = inTimeComponents[3]

        let outTimeComponents = clockOut
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .components(separatedBy: " ")
        self.endTime = "\(outTimeComponents[1]) \(outTimeComponents[2])"

    }

    let startTime: String
    let endTime: String
    let account: String
    let description: String
}

func parse(timeclock: String) -> [RawTimeEntry] {
    let lines = data
        .trimmingCharacters(in: .whitespacesAndNewlines)
        .components(separatedBy: "\n")
        .filter { $0.count != 0}

    var rawTimeEntries = [RawTimeEntry]()
    var i = 0
    repeat {
        let clockIn = lines[i]
        let clockOut = lines[i+1]
        rawTimeEntries.append(RawTimeEntry(clockIn: clockIn, clockOut: clockOut))
        i += 2
    } while i < lines.count

    return rawTimeEntries
}

for entry in parse(timeclock: data) {
    print(entry)
}

//: [Next](@next)
