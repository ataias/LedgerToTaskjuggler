import XCTest
@testable import LedgerToTaskjuggler

final class ledger_to_tjTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let booking = Booking(account: "TEST", date: "2020-04-08", hourDuration: 2.4)
        XCTAssertEqual(booking.date, "2020-04-08")
    }

    func testParsingTimeclockFile() {
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
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
