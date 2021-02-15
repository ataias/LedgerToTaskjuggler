import Foundation

public func createBookingLines(from: [Booking]) -> [String] {
    // TODO Get bookings in the style below

    let bookingsByDate = Dictionary(grouping: from.filter { b in b.hourDuration != 0.0 }, by: { $0.date })

    return bookingsByDate.map {(_, bookings) in bookings}.sorted { (b1, b2) in b1[0].date < b2[0].date }.flatMap { dayBookings -> [String] in
        let diffInitialTime = dayBookings.reduce([0.0]) { acc, booking in
            (acc + [acc.last! + booking.hourDuration])
        }
        return zip(diffInitialTime, dayBookings).map { (diffTime: Double, booking: Booking) -> String in
            let hour = Int(booking.hourDuration * 60.0).roundInt(by: 5)
            let hourDiff = Int(diffTime)
            let minuteDiff = Int((diffTime - Double(hourDiff))*60.0)
            let formattedHour = String(format: "%02d", arguments: [9+hourDiff])
            let formattedMinute = String(format: "%02d", arguments: [minuteDiff.roundInt(by: 5)])
            let formattedDuration = String(format: "%dmin", arguments: [hour])
            return """
                booking \(booking.account)
                    \(booking.date)-\(formattedHour):\(formattedMinute) + \(formattedDuration) {overtime 1}
            """
        }
    }
}

public func getNewBookings(csv: String, accountPrefix: String) -> [Booking] {
    let lines = csv.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: "\n")
    let matrix = lines
      .map { $0.components(separatedBy: ",").map { $0.trimmingCharacters(in: CharacterSet(charactersIn: "\"h")) } }
    return matrix[1..<matrix.count-1].flatMap { row -> [Booking] in
        return row[1...].enumerated().map { (j, duration) -> Booking in
            let accountWithoutPrefix: String = row[0]
                .deletingPrefix(accountPrefix)
                .lowercased()
                .replacingOccurrences(of: ":", with: ".")
            return Booking(account: accountWithoutPrefix, date: matrix[0][j+1], hourDuration: Double(duration)!)
        }

    }
}

public func getNewBookings(timeclock: String, accountPrefix: String) -> [Booking] {
    let lines = timeclock.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: "\n")
    return []
}


//func getDateRange(bookingsFilename: String) -> (String, String)? {
//    let bookings = try! String(contentsOfFile: bookingsFilename)
//    let dateMatches = matches(for: "\\d{4}-(0[1-9]|1[012])-(0[1-9]|[12][0-9]|3[01])", in: bookings).sorted(by: >)
//    if dateMatches.count == 0 {
//        return nil
//    }
//    let lastDateStr = dateMatches[0]
//    let lastDate = Booking.dateFormatter.date(from: lastDateStr)!
//    let fromDate = (Booking.dateFormatter.string(from: lastDate - 1))
//    let toDate = Booking.dateFormatter.string(from: Date())
//    return (fromDate, toDate)
//}

// https://stackoverflow.com/questions/27880650/swift-extract-regex-matches#27880748
func matches(for regex: String, in text: String) -> [String] {

    do {
        let regex = try NSRegularExpression(pattern: regex)
        let results = regex.matches(in: text,
                                    range: NSRange(text.startIndex..., in: text))
        return results.map {
            String(text[Range($0.range, in: text)!])
        }
    } catch let error {
        print("invalid regex: \(error.localizedDescription)")
        return []
    }
}

public func shell(launchPath: String, arguments: [String]) -> String {

    let process = Process()
    process.launchPath = launchPath
    process.arguments = arguments

    let pipe = Pipe()
    process.standardOutput = pipe
    process.launch()

    let output_from_command = String(data: pipe.fileHandleForReading.readDataToEndOfFile(), encoding: String.Encoding.utf8)!

    // remove the trailing new-line char
    if output_from_command.count > 0 {
        let lastIndex = output_from_command.index(before: output_from_command.endIndex)
        return String(output_from_command[output_from_command.startIndex ..< lastIndex])
    }
    return output_from_command
}

func %(value:Double, format:String) -> String {
    return String(format:format, value)
}

