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

    static var allTests = [
        ("testExample", testExample),
    ]
}
